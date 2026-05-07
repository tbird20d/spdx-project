#!/bin/sh
# get-files-from-sbom.sh - get a flat list of source files from
#  a source sbom produced by the kernel sbom tool
# usage: get-files-from-sbom.sh sbom-source.spdx.json

if [ ! -f "$1" ] ; then
    cat <<USAGE
Usage: get-files-from-sbom.sh <sbom-source-spdx-json-filename>

Generates a list of files in the kernel source tree based
on the provided file, which should be a KernelSbom file
This is usually named sbom-source.spdx.json, and is located
in the build output directory for the build.
USAGE
    exit 1
fi

# convert json to pretty format, find "name": lines, strip junk, sort and filter

# omit 'name: KernelSbom' line
# note: first line of the sorted list are bogus:
# '$(src-tree)'
# remove them with: tail -n+2
# also remove leading "linux/" in filenames

# here it is in all its glory
cat $1 | jq | grep \"name\": | grep -v "KernelSbom" | sed -e 's/.*name\": \"//' | sed -e 's/\",$//' | sort | tail -n+2 | sed -e "s/^linux\///"

