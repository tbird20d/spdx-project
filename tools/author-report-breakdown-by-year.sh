#!/bin/sh
# author-report-breakdown-by-year.sh
# usage: author-report-breakdown-by-year.sh [<spdx-data-file>]

#set -x

SPDX_DATA=spdx-line-data.csv
if [ -n "$1" ] ; then
    SPDX_DATA="$1"
fi

if [ ! -e "$SPDX_DATA" ] ; then
    echo "Error: SPDX data file '$SPDX_DATA' is not found"
    exit 1
fi

echo "Year breakdown for '$SPDX_DATA)'"
echo "Year  Number of SPDX id lines introduced"
echo "====  =================================="

for year in $(seq 2016 2026) ; do echo -n "$year  " ; grep -c "$year-" $SPDX_DATA ; done

# report total
echo "----  ----------------------------------"
echo -n "TOTAL " ; cat $SPDX_DATA | wc -l
