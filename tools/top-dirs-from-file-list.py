#!/usr/bin/python3

# show counts of top directories for a list of files

# usage: top-dirs-from-file-list.py

import os
import sys

from operator import itemgetter

if "-h" in sys.argv:
    print("""Usage: top-dirs-from-file-list [<files-list-file>]

Read a list of file paths, and create a summary report of
the counts for each top directory in the list.

If no argument is provided, read the file list from stdin.

Options:
 -h    Show this usage help
 -v    Verbose.  Show counts for top dirs, and for one level down.
""")
    sys.exit(0)

show_missing = True
verbose = False
if "-v" in sys.argv:
    sys.argv.remove("-v")
    verbose = True

# automatically omit missing file warnings if we're not in a kernel tree
if not os.path.isfile("MAINTAINERS"):
    show_missing = False

try:
    file_list_file = sys.argv[1]
except:
    file_list_file = "/dev/stdin"

dir_count = {}
dir_count2 = {}
for line in open(file_list_file, "r").readlines():
    line = line.strip()

    # warn about missing files
    # this should be rare - only if file list is for different kernel
    # version than one we're in
    if show_missing and not os.path.isfile(line):
        print("Warning: missing file '%s'" % line)
        continue

    top_dir = line.split("/")[0]
    dir_count[top_dir] = dir_count.get(top_dir, 0) + 1
    dir_count2[top_dir] = dir_count2.get(top_dir, 0) + 1
    try:
        top2_dir = "/".join(line.split("/")[0:2])
        dir_count2[top2_dir] = dir_count2.get(top2_dir, 0) + 1
    except:
        pass

dirvals = dir_count.items()
dirvals = sorted(dirvals, key=itemgetter(1))

print("top dirs for '%s':" % file_list_file )
print("-------------------------------------")
total_count = 0
for dirname, count in dirvals:
    print(f"{dirname:20} = {count:5} files")
    total_count += count

print("-------------------------------------")
dirname = "Total"
print(f"{dirname:20} = {total_count:5} files")

if verbose:
    print("="*40)
    print("top dirs with subdirs:")
    print("-------------------------------------")
    dirvals = dir_count2.items()
    dirvals = sorted(dirvals, key=itemgetter(0))
    for dirname, count in dirvals:
        if "/" in dirname:
            print(f"  {dirname:28} = {count:5} files")
        else:
            print(f"{dirname:30} = {count:5} files")
