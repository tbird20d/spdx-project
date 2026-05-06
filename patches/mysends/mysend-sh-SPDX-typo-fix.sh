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
    --dry-run \
    --smtp-pass=13Zeebras!ster \
--to=brgl@kernel.org \
--to=ysato@users.sourceforge.jp \
--to=dalias@libc.org \
--to=glaubitz@physik.fu-berlin.de \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-sh@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-sh-fix-typo-in-SPDX-license-id-lines.patch
