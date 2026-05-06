#!/bin/sh
# source-without-spdx.sh - show a list of source code for an
# indicated directory that are missing spdx id lines
#
# Usage: source-without-spdx.sh [<dir>]

START_DIR="."
if [ -n "$1" ] ; then
    START_DIR="$1"
fi
find "$START_DIR" -name "*.[chS]" | xargs grep -L "SPDX-License-Identifier"
