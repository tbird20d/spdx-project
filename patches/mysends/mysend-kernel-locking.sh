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
--to=mingo@redhat.com \
--to=peterz@infradead.com \
--to=will@kernel.org \
--to=boqun.feng@gmail.com \
--to=longman@redhat.com \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-kernel-locking-Add-SPDX-license-ids-to-some-files.patch
