#!/bin/sh
# do-missing-test-and-post.sh
#
## support -i for specifing the input file (results), instead of
# running the test
#
if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    cat <<USAGE
Usage: do-missing-test-and-post.sh [options]

Perform get-kernel-spdx-missing-list-top-dirs.sh, and post it
to Tim Bird's boot-time wiki.

Options:
 -h or --help   Show this usage help
 -i <infile>    Use <infile> instead of running the test
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

TIMESTAMP="$(date +%Y-%m-%d_%H:%M:%S)"
PAGE_NAME="Kernel_Dirs_Missing_SPDX_Counts_$TIMESTAMP"

# NOTE: use 'put_page' instead of 'put' command because page name
# has colons
echo "Putting data to boot-time wiki..."
tbclient -w birdcloud.org:/bc put_page $PAGE_NAME --infile $RESULTS_FILE
