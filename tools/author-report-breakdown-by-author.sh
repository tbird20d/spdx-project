#!/bin/sh
# author-report-breakdown-by-year.sh
# usage: author-report-breakdown-by-year.sh [-n <count>] [-v] [<data-file>]

#set -x

MAX_COUNT=10
if [ "$1" = "-n" ] ; then
    MAX_COUNT=$2
    shift
    shift
fi

SPDX_DATA=spdx-line-data.csv
if [ -n "$1" ] ; then
    SPDX_DATA="$1"
fi

if [ ! -e "$SPDX_DATA" ] ; then
    echo "Error: Author report '$SPDX_DATA' is not found"
    exit 1
fi

echo "Author breakdown for $SPDX_DATA"

# replace commas in filenames with dashes, then print the 5th record
# then sort and count, then sort the counts
cat $SPDX_DATA | sed "s/\\([a-z]\\),/\1-/" | awk -F, '!/^#/ {print $5}' | sort | uniq -c | sort -n -r >/tmp/spdx-authors.txt

#cat /tmp/spdx-authors.txt

echo "  Count Author"
echo "  ----- ----------------------------------"

output_count=0
while IFS= read count_author ; do
    output_count=$(( output_count + 1 ))
    if [ "$output_count" -gt "$MAX_COUNT" ] ; then
        break
    fi
    echo "$count_author"
done </tmp/spdx-authors.txt

# report total
echo "..."
echo "  -----  ----------------------------------"
echo -n "TOTAL SPDX ID AUTHORS: " ; cat /tmp/spdx-authors.txt | wc -l

rm /tmp/spdx-authors.txt
