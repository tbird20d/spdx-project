#!/bin/sh
# gen-spdx-top-dir-report.sh
# generate a list of spdx stats at the top directory
# this should be run at the top of the kernel source tree
if [ ! -f MAINTAINERS ] ; then
    echo "Please run from the top directory of a Linux kernel source tree"
    exit 1
fi

for i in $(find . -maxdepth 1 -type d | cut -b 3- | grep -v ^[.]) ;  do
    echo "== $i =="
    scripts/spdxcheck.py -v $i 2>&1
done
