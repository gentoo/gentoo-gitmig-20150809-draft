#!/bin/bash
# This script is a companion script to the Gentoo freenet init script.
# Logs freenet's stdout and stderr for debugging needs.
#
# Author: Brandon Low <lostlogic@gentoo.org>
#
${JAVA} ${JAVA_ARGS} freenet.node.Main -p /etc/freenet.conf \
	> /var/freenet/freenet.stdout.log 2> /var/freenet/freenet.stderr.log &
echo $!
