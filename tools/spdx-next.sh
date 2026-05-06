#!/bin/sh
# spdxnext.sh - show the next set of files to work on for
# adding missing SPDX-License-Identifier lines
#
# init ipc io_uring mm security usr
#WORKING_AREAS="init ipc io_uring mm security usr"
#WORKING_AREAS="io_uring mm security"
WORKING_AREAS="sound crypto net lib"
#WORKING_AREAS="arch include drivers"
#

ARGS=-e scripts/spdx-omit-nobuild-files

# next area to work on:
# sound

if [ ! -f MAINTAINERS ] ; then
    echo "Please run this script at the root of a kernel source tree"
    exit 1
fi

for AREA in $WORKING_AREAS ; do
    echo "Source files missing SPDX-License-Identifier lines in '$AREA':"
    scripts/spdxcheck.py $ARGS -f $AREA 2>&1 | grep [.][chS]
done
