#!/bin/sh
# scan a build log (created with 'make V=1 EXTRA_CFLAGS=-v <target>')
# and output a list of source files that were used in the build

# usage: scan-build-log.sh <build.log>

if [ -z "$1" ] ; then
    echo "Missing <build.log> argument"
    echo "Use -h for help"
    exit 1
fi

if [ "$1" = "-h" ] ; then
    cat <<END
Usage: scan-build-log.sh <build.log>"
This scans a build log for the Linux kernel, and outputs a list
of source files referenced in the build.

A build log can be created by using the arguments: V=1 EXTRA_CFLAGS=-v with
the kernel make command, and putting the output (both stdout and stderr) to
a file, like so:

 $ make V=1 EXTRA_CFLAGS=-v vmlinux 2>&1 | tee build.log

END
    exit 0
fi

echo "Source files mentioned in the build log:"
# have sort to use ASCII sorting
export LC_ALL=C
grep -o "[^ ]*[.][chS]\($\|[ ]\)" $1 | grep / | sed "s/ *$//" | sort | uniq

