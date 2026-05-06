#!/bin/sh
# get-missing-spdx-for-source-files.sh
#

if [ ! -f "MAINTAINERS" ] ; then
    echo "Error: You must run this at the root of a kernel source tree"
    exit 1
fi

if [ "$1" = "-h" ] ; then
    cat <<HERE
Usage: get-missing-spdx-for-source-files.sh [options] [<output_file>]

Produce a list of source files that are missing SPDX license id lines.
This is just a wrapper around 'check-files-for-spdx.sh', but with
an extra step to generate the list of source files.

If <output_file> is specified, write data to that file.
HERE
    exit 0
fi

SOURCES_FILE=$(mktemp -q)

# if user specifies an output file, pipe to tee, else just cat the results
OUTPUT_CMD="cat"
if [ -n "$1" ] ; then
    OUTPUT_CMD="tee $1"
fi

find . -name "*.[chS]" >$SOURCES_FILE
check-files-for-spdx.sh $SOURCES_FILE | $OUTPUT_CMD

rm $SOURCES_FILE
