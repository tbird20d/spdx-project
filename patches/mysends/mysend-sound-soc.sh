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
--to=perex@perex.cz \
--to=tiwai@suse.com \
--to=lgirdwood@gmail.com \
--to=broonie@kernel.org \
--to=povik+lin@cutebit.org \
--to=david.rhodes@cirrus.com \
--to=rf@opensource.cirrus.com \
--to=cezary.rojewski@intel.com \
--to=peter.ujfalusi@linux.intel.com \
--to=yung-chuan.liao@linux.intel.com \
--to=ranjani.sridharan@linux.intel.com \
--to=kai.vehmanen@linux.intel.com \
--cc=linux-spdx@vger.kernel.org \
--cc=asahi@lists.linux.dev \
--cc=patches@opensource.cirrus.com \
--cc=linux-sound@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-sound-soc-Add-SPDX-ids-to-many-soc-files.patch

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


