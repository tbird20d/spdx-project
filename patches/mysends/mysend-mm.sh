#!/bin/sh
# mysend.sh is my personal script used to send patches to the
#   upstream kernel
#
# some handy options:
#    --smtp-debug=1 \
#    --smtp-pass={password} \
#    --bcc= \
#    --dry-run \
#
# This script will send the patch through whatever email server is
# configured for git.  As of Jan 2026, this was:
# $ git config -l | grep send
# sendemail.smtpserver=mail.bird.org
# sendemail.smtpserverport=465
# sendemail.smtpencryption=ssl
# sendemail.smtpuser=tim@bird.org

git send-email \
    --smtp-pass=13Zeebras!ster \
--to=kbusch@kernel.org \
--to=willy@infradead.org \
--to=kirill@shutemov.name \
--to=aneesh.kumar@kernel.org \
--to=mike.kravetz@oracle.com \
--to=peterz@infradead.org \
--to=akpm@linux-foundation.org \
--to=riel@surriel.com \
--to=torvalds@linuxfoundation.org \
--to=david@kernel.org \
--to=muchun.sony@linux.dev \
--to=osalvador@suse.de \
--to=hughd@google.com \
--to=will@kernel.org \
--to=npiggin@gmail.com \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-mm@kvack.org \
--cc=linux-arch@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-mm-Add-SPDX-id-lines-to-some-mm-source-files.patch
