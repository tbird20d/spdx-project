#!/bin/sh
#
# git-when-deleted.sh - show the log for a file (even if it's
# deleted.  The last commit should have the file deletion or
# incorporation into another file.
#
# Usage: git-when-deleted.sh [-v] {filename} [{filename2}...]
if [ "$1" = "-h" ] ; then
    echo "Usage: git-when-deleted.sh [-v] [-1] {filename} [{filename2}...]"
    echo "Options:"
    echo "  -h   Show this usage help"
    echo "  -1   Show only first commit"
    exit 0
fi

if [ "$1" = "-v" ] ; then
    shift
    set +x
fi

if [ "$1" = "-1" ] ; then
    ARGS="-1"
fi

for item do
    git log --all $ARGS -- $item
done
