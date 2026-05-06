#!/bin/bash
# spdx-count-ids.sh - scan a directory and count the
# SPDX-License-Identifier lines currently in use in the files there.

#set -x

if [ "$1" = "-h" ] ; then
    cat <<HERE
Usage: spdx-count-ids.sh [-h][-v]

Scan a directory and count uses of different SPDX IDs

Options:
 -h    Show this usage help
 -v    Verbose mode. Show specific files with OR or other licenses
HERE
    exit 0
fi

if [ "$1" = "-v" ] ; then
    VERBOSE=1
fi

do_count() {
    count=$(cgrep SPDX-License | grep "$1" | wc -l)
    printf "%5s  '%s'\n" $count "$1" $2
}

do_count "GPL-2.0$"
count2=$count
do_count "GPL-2.0 "
count2=$(( $count2 + $count ))
printf "%5s  '= GPL-2.0 Total'\n" $count2

do_count "GPL-2.0-only"
do_count "GPL-2.0-or-later"
do_count "GPL-2.0+"

do_count " OR "
if [ -n "$VERBOSE" ] ; then
    cgrep SPDX-License | grep " OR "
fi

do_count " AND "
if [ -n "$VERBOSE" ] ; then
    cgrep SPDX-License | grep " AND "
fi

## do others (non-GPL)
count=$(find . -path "./.git" -prune -o -path "./kbuild*" -prune -o -name "*.[chS]" | xargs grep SPDX-License | grep -v GPL | wc -l)
printf "%5s  Other licenses\n" $count

if [ -n "$VERBOSE" ] ; then
    find . -path "./.git" -prune -o -path "./kbuild*" -prune -o -name "*.[chS]" | xargs grep SPDX-License | grep -v GPL
fi

## show totals
count="$(cgrep SPDX-License | wc -l)"
printf "%5s  Source files (with SPDX-License-ID lines)\n" $count

count="$(find . -path "./.git" -prune -o -path "./kbuild*" -prune -o -name "*.[chS]" | xargs grep -L SPDX-License | wc -l)"
    printf "%5s  Missing SPDX\n" $count
if [ -n "$VERBOSE" ] ; then
    find . -path "./.git" -prune -o -path "./kbuild*" -prune -o -name "*.[chS]" | xargs grep -L SPDX-License
fi

count=$(find . -path "./.git" -prune -o -path "./kbuild*" -prune -o -name "*.[chS]" | wc -l)
    printf "%5s  Total Source Files\n" $count
