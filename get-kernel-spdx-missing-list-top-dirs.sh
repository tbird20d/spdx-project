#!/bin/bash
# show a list of kernel top source directories, and the number of
# SPDX files each is missing

if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    echo "Usage: get-kernel-spdx-missing-list-top-dirs.sh [-d|-h]"
    echo
    echo "Show the count of files missing SPDX headers in the source"
    echo "tree for the Linux kernel."
    echo
    echo "Options:"
    echo " -h, --help  = Show this usage help"
    echo " -d          = Show info for sub-dirs of 'drivers'"
    echo " -a          = Show info for sub-dirs of 'arch'"
    exit 1
fi

KERNEL_SRC=/home/tbird/work/torvalds/linux

DIR_LIST="arch block certs crypto drivers fs include init io_uring ipc \
    kernel lib mm net security sound usr virt"
FORMAT_STR="Directory '%8s'- "


pushd $KERNEL_SRC

if [ "$1" = "-d" ] ; then
    DIR_LIST="$(find drivers -maxdepth 1 -type d | grep -v sfi | grep -v vme | sort)"
    FORMAT_STR="Directory '%21s'- "
fi

if [ "$1" = "-a" ] ; then
    DIR_LIST="$(find arch -maxdepth 1 -type d | grep -v sfi | grep -v vme | sort)"
    FORMAT_STR="Directory '%15s'- "
fi

for d in $DIR_LIST ; do
    printf "$FORMAT_STR" $d
    scripts/spdxcheck.py $d -v 2>&1 | grep without
done

popd

