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
--to=perex@perex.cz \
--to=tiwai@suse.com \
--to=clemens@ladisch.de \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-sound@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
v2-0001-ALSA-usb-audio-Add-SPDX-id-to-midi.c.patch

