#!/bin/bash
# show a list of kernel top source directories, and the number of
# SPDX files each is missing

usage() {
    cat <<USAGE
Usage: get-kernel-spdx-missing-list-top-dirs.sh [<options>]

Show the count of files missing SPDX headers in the source
tree for the Linux kernel.

Options:
 -h, --help  = Show this usage help
 -c          = Show core kernel dirs only (Omit arch and drivers)
 -d          = Show info for sub-dirs of 'drivers'
 -a          = Show info for sub-dirs of 'arch'
 -b          = Add triple-braces around output.
               This is useful when putting output directly to a wiki.
USAGE
    exit 1
}

# parse arguments
while [ -n "$1" ] ; do
    if [ "$1" = "-h" -o "$1" = "--help" ] ; then
        usage
    fi
    if [ "$1" = "-b" ] ; then
        SHOW_BRACES=1
        shift
        continue
    fi
    if [ "$1" = "-d" ] ; then
        SHOW_DRIVER_DIR=1
        shift
        continue
    fi
    if [ "$1" = "-a" ] ; then
        SHOW_ARCH_DIR=1
        shift
        continue
    fi
    if [ "$1" = "-c" ] ; then
        CORE_ONLY=1
        shift
        continue
    fi
    echo "Unknown arg '$1', use -h for usage help"
done

KERNEL_SRC=/home/tbird/work/torvalds/linux

DIR_LIST="arch block certs crypto drivers fs include init io_uring ipc \
    kernel lib mm net security sound usr virt"
FORMAT_STR="Directory '%8s'- "

if [ -n "$CORE_ONLY" ] ; then
    DIR_LIST="block certs crypto fs include init io_uring ipc \
        kernel lib mm net security sound usr virt"
fi

pushd $KERNEL_SRC >/dev/null

if [ -n "$SHOW_DRIVER_DIR" ] ; then
    DIR_LIST="$(find drivers -maxdepth 1 -type d | grep -v sfi | grep -v vme | sort)"
    FORMAT_STR="Directory '%21s'- "
fi

if [ -n "$SHOW_ARCH_DIR" ] ; then
    DIR_LIST="$(find arch -maxdepth 1 -type d | grep -v sfi | grep -v vme | sort)"
    FORMAT_STR="Directory '%15s'- "
fi

if [ -n "$SHOW_BRACES" ] ; then
    echo "{{{"
fi

echo "Here is a summary of the top-level Linux kernel source tree directories"
echo "and how many source files are missing SPDX headers"
echo "=================================================="
echo -n "KERNEL_SRC="
pwd
echo -n "KERNEL_VERSION="
git describe
echo -n "TEST_DATE="
date +%Y-%m-%d_%H:%M:%S

echo "=================================================="

TOTAL_COUNT=0
for d in $DIR_LIST ; do
    printf "$FORMAT_STR" $d
    scripts/spdxcheck.py $d -v 2>&1 | grep without
    # doing this twice is wasteful, but
    # just echoing $LINE doesn't preserve spacing
    LINE=$(scripts/spdxcheck.py $d -v 2>&1 | grep without)
    NUMS="${LINE##*:}"
    COUNT="${NUMS% *}"
    TOTAL_COUNT=$(( TOTAL_COUNT + COUNT ))
done
#      "Directory ' include' - Files without SPDX:
printf "Total                 Files without SPDX: %11d\n" $TOTAL_COUNT
echo "=================================================="
if [ -n "$SHOW_BRACES" ] ; then
    echo "}}}"
fi

popd >/dev/null

