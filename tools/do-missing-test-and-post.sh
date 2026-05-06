#!/bin/sh
# do-missing-test-and-post.sh
#

# uncomment the next line to debug
#set -x

if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    cat <<USAGE
Usage: do-missing-test-and-post.sh [options]

Perform get-kernel-spdx-missing-list-top-dirs.sh, and post it
to Tim Bird's boot-time wiki.

!! Note: This script needs 'tbclient' to upload the page to the wiki.

Options:
 -h or --help   Show this usage help
 -i <infile>    Use <infile> instead of running the test
 -r             Remove file after posting it to the wiki
USAGE
    exit 0
fi

RESULTS_FILE=spdx-missing-results.txt

if [ "$1" = "-i" ] ; then
    shift
    RESULTS_FILE=$2
    shift
    if [ ! -f $RESULTS_FILE ] ; then
        echo "Error: missing results file '$RESULTS_FILE'"
        exit 1
    fi
else
    ./get-kernel-spdx-missing-list-top-dirs.sh -b | tee $RESULTS_FILE
fi

if [ "$1" = "-r" ] ; then
    shift
    REMOVE_FILE=1
fi

TIMESTAMP="$(date +%Y-%m-%d_%H:%M:%S)"
PAGE_NAME="Kernel_Dirs_Missing_SPDX_Counts_$TIMESTAMP"

# NOTE: use 'put_page' instead of 'put' command because page name
# has colons
echo "Putting data to boot-time wiki..."
tbclient -w birdcloud.org:/bc put_page $PAGE_NAME --infile $RESULTS_FILE

if [ -n "$REMOVE_FILE" ] ; then
    echo "Removing results file..."
    rm $RESULTS_FILE
fi

echo "  You should be able to access the test results at:"
echo "     https://birdcloud.org/bc/$PAGE_NAME"
echo "       or possibly"
echo "     https://birdcloud.org/bc/KTest_Missing_SPDX"
echo "       if this is the latest test results file"
