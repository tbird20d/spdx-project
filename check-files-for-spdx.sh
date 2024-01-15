#!/bin/sh
# check-files-for-spdx.sh
#  read a list, and for each file, use spdxcheck.py
#  to find out if the file has an SPDX header or not

# output a csv file indicating the status:
#  "has spdx" = file has an spdx header
#  "no spdx"  = does not have an spdx header

FILE_LIST=$1

if [ -z "$FILE_LIST" ] ; then
    echo "Missing <file-list-file> argument"
    echo "Use -h for usage help"
    exit 1
fi

if [ "$1" = "-h" ] ; then
    cat <<USAGE
Usage: check-files-for-spdx.sh <file-list-file>

Read a file containing the list of files, and check
whether each one has an SPDX ID line or not.

Output is in CSV format, where the first field is the filename,
and the second field indicates whether the file has an
SPDX identifier line or not:

  has spdx = has an SPDX id line
  no spdx  = does not have an SPDX id line

USAGE
    exit 1
fi

for i in $(cat $BUILD_SRC) ; do
    echo -n "$i,"
    res=$(scripts/spdxcheck.py -f $i 2>&1 | grep SPDX)
    if [ -n "$res" ] ; then
        echo "no spdx"
    else
        echo "has spdx"
    fi
done
