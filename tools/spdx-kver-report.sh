#!/bin/bash
# spdx-kver-report.sh - check out a kernel version, and report
#  the number of files  SPDX-License-Identifier lines currently
#  in the files there.

#set -x

if [ "$1" = "-h" ] ; then
    cat <<HERE
Usage: spdx-kver-report.sh [-h] [<commit-ref>]

Report the total number of files that have SPDX-License-Identifier lines,
for the given <commit-ref>.  <commit-ref> can be a version tag (e.g. v7.0)

Options:
 -h    Show this usage help
HERE
    exit 0
fi

if [ ! -f MAINTAINERS ] ; then
    echo "Error: you must be at the root of a kernel tree to run this"
    exit 1
fi

if [ -z "$1" ] ; then
    echo "Error: you must provide a commit-ref (usually a kernel version)"
    exit 1
fi

KVER="$1"
git checkout $KVER

desc="$(git describe)"
count=$(grep -R -l SPDX-License-Identifier * | wc -l)
missing=$(grep -R -L SPDX-License-Identifier * | wc -l)

printf "%6s - %25s = %6d, %d missing\n" $KVER $desc $count $missing
git checkout master

exit 0

# years and first kernel release versions for that year
# 2010 v2.6.33
# 2011 v2.6.37
# 2012 v3.2
# 2013 v3.8
# 2014 v3.13
# 2015 v3.19
# 2016 v4.4
# 2017 v4.10
# 2018 v4.15
# 2019 v5.0
# 2020 v5.5
# 2021 v5.11
# 2022 v5.16
# 2023 v6.2
# 2024 v6.7
# 2025 v6.13
# 2026 v6.19
# current v7.1-rc2

VER_LIST="v2.6.33 v2.6.37 v3.2 v3.8 v3.13 v3.19 v4.4 v4.10 v4.15 v5.0 v5.5 v5.11 v5.16 v6.2 v6.7 v6.13 v6.19 v7.0"

for KVER in $VER_LIST ; do
    echo "=== Trying version $KVER..."
    git checkout $KVER -b "mybranch-$KVER"

    desc="$(git describe)"
    count=$(grep -R -l SPDX-License-Identifier * | wc -l)
    missing=$(grep -R -L SPDX-License-Identifier * | wc -l)

    printf "%6s - %25s = %6d, %d missing\n" $KVER $desc $count $missing
    git clean -fd
done
