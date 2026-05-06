#!/bin/sh
# get-files-from-sbom.sh - get a flat list of source files from
#  a source sbom produced by the kernel sbom tool
# usage: get-files-from-sbom.sh sbom-source.spdx.json

if [ ! -f "$1" ] ; then
    echo "Usage: get-files-from-sbom.sh sbom-source.spdx.json"
    exit 1
fi

# convert json to pretty format, find "name": lines, strip junk and sort
cat $1 | jq | grep \"name\": | sed -e 's/.*name\": \"//' | sed -e 's/\",$//' | sort | tail -n+3 | sed -e "s/^linux\///"

# note: first two lines of the sorted list are bogus:
# $(src-tree), KernelSbom"
# remove them with: tail -n+3
#
# also remove leading "linux/" in filenames
