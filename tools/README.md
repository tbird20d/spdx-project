Here is some information about the tools in this directory:

The tools fall into 4 categories:
 helper tools, file list checkers, report tools, build log scanner

# Tools

 * helper tools:
   * guess-license - scan file for license text and suggest an appropriate SDPX-license identifier line
   * spvi - adds an SPDX id line to a file, then opens it for editing
     - you can control which id it adds with a command line option
   * git-when-introduced.sh - provide info on when a file was first introduced into the kernel source tree
     - should be used in a Linux repo with full history
   * git-when-deleted.sh - provide info on when a file was deleted from the kernel source tree
   * files-worked-on - show files that were worked on (based on commits that match certain criteria: author, date range, etc.)
   * diffinfo - do patch analysis similar to diffstat, but with options for filtering files and hunks
   * spdx-next.sh - has a list of the next directories to work on
   * spdx-count-ids.sh - generates a list of the different ids used in a directory

 * file list checkers: (check specific file lists for missing spdx id lines)
   * check-files-for-spdx.sh - scan a list of files for spdx id lines
   * top-dirs-from-file-list.py - gives counts of how many files are in each top dir (used to see missing counts from build data)
   * get-missing-spdx-for-source-files.sh - scan only source files for missing spdx id lines

 * report tools: (generate kernel reports):
   * gen-spdx-top-dir-report.sh - generates a detailed set of stats from spdxcheck
     - produces details spdxcheck reports
   * report-spdx-data.sh - finds all spdx lines, their author and date of introduction
     - generates a csv file
   * author-report-breakdown-by-author.sh
   * author-report-breakdown-by-year.sh
   * get-kernel-spdx-missing-list-top-dirs.sh - creates a summary report of missing files for top kernel dirs
   * do-missing-test-and-post.sh - creates a missing report and posts it to a wiki
     - sends data to the wiki at: https://birdcloud.org/bc

 * build log scanner:
   * scan-build-log - my attempt at deriving build files from output of kernel make

# Data
 * scripts/spdx-omit-nobuild-files
   * files to omit some files and dirs from inclusion in spdxcheck.py reports
     * to be put in: scripts/spdx-omit-nobuild-files in a kernel source tree

# Other
Tools and data not in this directory:
~/work/kselftest/ktap-benchmark-support/spdx-missing-test.sh
 - produces ktap value lines and results lines for kernel top-level directories
 - uses ~/work/kselftest/ktap-benchmark-support/process-results.py and
 - /home/tbird/spdx-stuff/sdpx-missing-[criteria|ref-value].txt files


# Workflows

## patch work
The general flow of operation for patch work is:
 * determine the file or set of files to work on
   * use spdx-next.sh or 'grep -L SPDX-License {dir}/* ' to find the next
   files to work on
 * research the license to add
   * use git-when-introduced.sh to get history info on a file, if needed
   * use guess-license to figure out the license to use, based on a
     file's license header text
   * use spdx-count-ids.sh or guess-license to see what other files in
     this sub-system are using for licenses. (ie maybe try to match them)
 * add the license:
   * use spvi to automatically pre-pend the right license format for
     the file type (.c or .h format)
 * create the patch, validate it, collect recipients
   * See **guidelines** for this
 * write a script (based on one in mysends dir) to send the patch
 * send the patch

## status checks
The general flow of operation for status report work is:
 * *FIXTHIS - add workflow here*

## report generation
 * *FIXTHIS - add workflow here*
