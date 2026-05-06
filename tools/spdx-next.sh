#!/bin/bash
# spdx-next.sh - show the next set of files to work on for
# adding missing SPDX-License-Identifier lines
#
# init ipc io_uring mm security usr
#WORKING_AREAS="init ipc io_uring mm security usr"
#WORKING_AREAS="io_uring mm security"
WORKING_AREAS="sound crypto net lib"
#WORKING_AREAS="arch include drivers"
#
#
# uncomment next line to debug
#set -x

DEFAULT_KERNEL_SRC=/home/tbird/work/torvalds/linux

if [ "$1" = "-h" ] ; then
    cat <<USAGE
Usage: spdx-next.sh [-h]

Show a list of the files to work on next for the SPDX project.
These are files in a specific directory (or set of directories)
that are missing SPDX ID lines.

To update the set of directories to report on, update the
WORKING_AREAS variable in this script.

If this script is not run at the top of a kernel source directory
then run it in the default location: $DEFAULT_KERNEL_SRC

Options:
 -h               Show this usage help
USAGE
    exit 0
fi


# arguments for spdxcheck.py
# limit scan to source files (omit files not used in a build)
ARGS=-e scripts/spdx-omit-nobuild-files

if [ ! -f MAINTAINERS ] ; then
    echo "Using default kernel src dir: $DEFAULT_KERNEL_SRC"
    pushd $DEFAULT_KERNEL_SRC >/dev/null
    DID_PUSHD=1
fi

echo "Working areas are: $WORKING_AREAS"

for AREA in $WORKING_AREAS ; do
    echo "Source files missing SPDX-License-Identifier lines in '$AREA':"
    scripts/spdxcheck.py $ARGS -f $AREA 2>&1 | grep [.][chS]
done

if [ -n "$DID_PUSHD" ] ; then
    popd >/dev/null
fi

