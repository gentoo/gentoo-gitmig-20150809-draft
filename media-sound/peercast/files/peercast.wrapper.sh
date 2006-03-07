#!/bin/sh
cd /usr/share/peercast
exec /usr/libexec/peercast "$@"
echo "$!" > /var/run/peercast.pid

