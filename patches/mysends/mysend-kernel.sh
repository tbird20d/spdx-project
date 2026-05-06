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
--to=rusty@rustcorp.com.au \
--to=karim.yaghmour@opersys.com \
--to=akpm@linuxfoundation.org \
--to=tglx@kernel.org \
--cc=kernelxing@tencent.com \
--cc=peterz@infradead.org \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
--in-reply-to=20260113234405.539422-1-tim.bird@sony.com \
v2-0001-kernel-Add-SPDX-License-Identifier-lines.patch
