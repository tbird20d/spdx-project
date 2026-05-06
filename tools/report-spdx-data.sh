#!/bin/bash
# SPDX-License-Identifier: MIT
# I'm making this MIT.
# Report when each SPDX-License-Identifier line was introduced + author
# A lot of this was produced by grok.com on 2026-05-05, with prompt:
# "I want a script that reports, for each SPDX-License-Identifier line in
# the kernel source tree, the date that line was introduced, and
# the author of the line.
#
# Refinements and non-grok stuff was produced by Tim Bird <tim.bird@sony.com>

#set -euo pipefail
#set -x
set -u
set -o pipefail


if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Run this script from inside a Linux kernel git repository"
    exit 1
fi

echo "Finding all SPDX-License-Identifier lines..."
echo "File,LineNumber,SPDX_Line,Date,Author,Commit"

# Find most source files containing SPDX id lines
git grep -n --full-name -E 'SPDX-License-Identifier:' -- '*.c' '*.h' '*.S' 'Makefile' '*.sh' '*.py' '*.pl' > /tmp/spdx_files.txt 2>/dev/null || true

echo "check file /tmp/spdx_files.txt"
read junk
echo "continuing.  This takes about 10 hours...."

while IFS= read -r line || [[ -n $line ]]; do
    file="${line%%:*}"
    lineno="${line#*:}"
    lineno="${lineno%%:*}"
    spdx_text="${line#*:*:}"
    #echo "line info: $file:$lineno:$spdx_text"

    # Get the commit that introduced this exact line using git blame
    blame=$(git blame -L "$lineno,$lineno" --porcelain -- "$file" 2>/dev/null | head -n 10)

    commit=$(echo "$blame" | grep -m1 '^commit ' | awk '{print $2}')
    author=$(echo "$blame" | grep -m1 '^author ' | sed 's/^author //')
    author_time=$(echo "$blame" | grep -m1 '^author-time ' | awk '{print $2}')
    date=$(date -u -d "@$author_time" '+%Y-%m-%d %H:%M:%S UTC' 2>/dev/null || echo "$author_time")

    #echo "data: $commit:$author:$date"

    # Clean up the SPDX line
    clean_spdx=$(echo "$spdx_text" | sed 's/^[ \t*#/]*//;s/[ \t]*$//')
    #echo "clean_spdx: $clean_spdx"


    printf '"%s",%s,"%s","%s","%s","%s"\n' \
        "$file" "$lineno" "$clean_spdx" "$date" "$author" "$commit"

done < /tmp/spdx_files.txt | tee /tmp/spdx-line-data.csv


rm -f /tmp/spdx_files.txt

