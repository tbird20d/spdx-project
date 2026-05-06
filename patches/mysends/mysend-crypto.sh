#!/bin/sh
# mysend.sh is my personal script used to send patches to the
#   upstream kernel
#
if [ "$1" = "-h" ] ; then
    echo "mysend.sh [-r]"
    echo
    echo "if -r is specified, send the patch for real (not a dry run)"
    exit 1
fi

DRY_RUN="--dry-run"
if [ "$1" = "-r" ] ; then
    DRY_RUN=""
fi

git send-email $DRY_RUN \
    --smtp-pass=13Zeebras!ster \
--to=herbert@gondor.apana.org.au \
--to=davem@davemloft.net \
--to=lukas@wunner.de \
--to=ignat@cloudflare.com \
--to=stefanb@linux.ibm.com \
--to=smueller@chronox.de \
--to=ajgrothe@yahoo.com \
--to=salvatore.benedetto@intel.com \
--to=dhowells@redhat.com \
--cc=linux-crypto@vger.kernel.org \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-crypto-Add-SPDX-ids-to-some-files.patch

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


