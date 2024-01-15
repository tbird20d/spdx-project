#!/bin/sh
# create-sdpx-lists.sh - convert files list to source list
# make lists of src files that are missing SPDX headers
# this filters a list of files missing  SPDX header to just the
# interesting source code

# filter out Documentation, tools, samples, scripts, and restrict
# output files to ones ending in .c, .h, or .S

# to be executed at the root of the Linux kernel source tree
FILE1=../files-missing-spdx-headers.txt
FILE2=../src-missing-spdx-headers.txt


if [ "$1" = "-h" ] ; then
    cat <<EOF
Usage: create-spdx-lists.sh

Create a list of files that are missing an SPDX header.
Then filters that list to just the interesting source code.

Files created are:
SRC=$FILE1
DEST=$FILE2

Filter out Documentation, tools, samples, scripts, and restrict
output files to ones ending in .c, .h, or .S

This should be run in the top level of the kernel source tree.
EOF
fi

tools/spdxcheck.py -f 2>$FILE1
cat $FILE1 | grep -v ./Documentation/ | grep -v ./tools/ | grep -v ./samples/ | grep -v ./scripts/| grep [.][chS]$ | cut -b 7- >$FILE2

echo -n "$FILE1 count:"
cat $FILE1 | wc -l

echo -n "$FILE2 count:"
cat $FILE2 | wc -l
