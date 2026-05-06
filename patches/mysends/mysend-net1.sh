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
--to=davem@davemloft.net \
--to=edumazet@google.com \
--to=kuba@kernel.org \
--to=pabeni@redhat.kernel.org \
--to=kuniyu@google.com \
--to=mubashirq@google.com \
--to=willemb@google.com \
--to=dsahern@kernel.org \
--to=pablo@netfilter.org \
--to=laforge@netfilter.org \
--to=fw@strlen.de \
--to=ncardwell@google.com \
--to=ycheng@google.com \
--to=xemul@parallels.com \
--to=idosch@mellanox.com \
--cc=tim.bird@sony.com \
--cc=netdev@vger.kernel.org \
--cc=netfilter-devel@vger.kernel.org \
--cc=coreteam@netfilter.org \
--cc=linux-spdx@vger.kernel.org \
--cc=linux-kernel@vger.kernel.org \
--bcc=tim@bird.org \
0001-net-Add-SPDX-ids-to-some-source-files.patch

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
