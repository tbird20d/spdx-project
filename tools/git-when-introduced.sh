#!/bin/sh
#
# git-when-introduced.sh - show the date and commit for when a file was
# introduced into the kernel
#
# Usage: git-when-introduced.sh [-v] {filename} [{filename2}...]
if [ "$1" = "-h" ] ; then
    echo "Usage: git-when-introduced.sh [-v] {filename} [{filename2}...]"
    exit 0
fi

if [ "$1" = "-v" ] ; then
    shift
    set +x
fi

for item do
    echo "== $item: "
    if [ ! -f $item ] ; then
        echo "  '$item' does not exist, no data"
        continue
    fi

    git_hash=$(git log --follow --format="%h" -- $item | tail -1)
    git_date=$(git show --format="%ad" --date "format:%a %b %d %Y" $git_hash | head -n 1)
    git_author=$(git log -n 1 --format="format:%an <%ae>" $git_hash)
    echo "  introduced: $git_date"
    echo "  commit: $git_hash"
    echo "  original author: $git_author"
    echo -n "  version: "
    git describe $git_hash --tags
done
