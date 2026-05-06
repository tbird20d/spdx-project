#!/bin/sh
# check-files-for-spdx.sh
#  read a list, and for each file, use grep
#  to find out if the file has an SPDX header or not

# output a csv file indicating the status:
#  "has spdx" = file has an spdx header
#  "no spdx"  = does not have an spdx header

# uncomment to debug
#set -x

usage() {
    cat <<USAGE
Usage: check-files-for-spdx.sh <files-list-file>

Read a file containing the list of files, and check
whether each one has an SPDX ID line or not.
If <files-list-file> is '--', then use 'find' to get the list
of files to scan.  If '-s' is specified, filter the list
to only source files.  If '-k' is specified, filter the
list to only source files used in a kernel image (omit tools,
scripts, etc.)

Output is in CSV format, where the first field is the filename,
and the second field indicates whether the file has an
SPDX identifier line or not:

  has spdx = has an SPDX id line
  no spdx  = does not have an SPDX id line

Options:
 -h    Show this usage help
 -m    Only show files missing an SPDX line.  In this mode, the
       output is NOT in CSV mode, but just a list of filenames.
 -s    Limit find to source files (files ending in .c, .h, and .S)
 -k    Omit files that are not part of a kernel image.
       This omits tools, scripts, etc.
 -d    Show debug output.

USAGE
    exit 1
}

while [ -n "$1" ] ; do
    case $1 in
        -h)
            usage
            ;;
        -d)
            set -x
            shift
            ;;
        -m)
            ONLY_MISSING=1
            shift
            ;;
        -s)
            SOURCE_ONLY=1
            shift
            ;;
        -k)
            KERNEL_SOURCE=1
            shift
            ;;
        --)
            USE_FIND=1
            shift
            ;;
        *)
            FILE_LIST=$1
            shift
            ;;
    esac
done

if [ -z "$FILE_LIST" -a -z "$USE_FIND" ] ; then
    echo "Missing file list. Use -h for usage help"
    exit 1
fi

if [ -n "$USE_FIND" ] ; then
    FILE_LIST=$(mktemp -q)
    if [ -n "$KERNEL_SOURCE" ] ; then
        if [ -n "$SOURCE_ONLY" ] ; then
            find . -type f -name "*.[chS]" | grep -v "./Documentation/" | \
                grep -v "./tools" | grep -v "./scripts" | grep -v "./samples" \
                | grep -v LICENSES  | grep -v "./kbuild" \
                >$FILE_LIST
        else
            find . -type f | grep -v "./Documentation/" | \
                grep -v "./tools" | grep -v "./scripts" | grep -v "./samples" \
                | grep -v LICENSES  | grep -v "./kbuild" \
                >$FILE_LIST
        fi
    else
        if [ -n "$SOURCE_ONLY" ] ; then
            find . -type f -name "*.[chS]" >$FILE_LIST
        else
            find . -type f >$FILE_LIST
        fi
    fi
    TMP_FILE=$FILE_LIST
fi

for f in $(cat $FILE_LIST) ; do
    # skip 'is' and 'missing', so we can run this file on its own output
    if [ "$f" = "is" ]  ; then
        continue
    fi
    if [ "$f" = "missing" ]  ; then
        continue
    fi
    if [ ! -f $f ] ; then
        echo "$f is missing"
        continue
    fi
    if grep -q -m 1 SPDX-License-Identifier $f ; then
        if [ -z "$ONLY_MISSING" ] ; then
            echo "$f, has spdx"
        fi
    else
        if [ -z "$ONLY_MISSING" ] ; then
            echo "$f, no spdx"
        else
            echo "$f"
        fi
    fi
done

# clean up temp files
if [ -n "$TMP_FILE" ] ; then
    # leave tmp file and report stats for debugging debug mode
    #echo TMP_FILE=$TMP_FILE
    #echo -n "Number of lines="
    #cat $TMP_FILE | wc -l

    rm $TMP_FILE
fi
