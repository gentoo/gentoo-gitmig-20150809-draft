#!/bin/sh
# Copyright 1999-2011 Gentoo Foundation
# Written by Roy Marples <uberlord@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# Alternatively, this file may be distributed under the terms of the BSD License
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/files/wpa_cli.sh,v 1.2 2011/07/07 07:54:55 gurligebis Exp $

if [ -z "$1" -o -z "$2" ]; then
	logger -t wpa_cli "Insufficient parameters"
	exit 1
fi

INTERFACE="$1"
ACTION="$2"

# Note, the below action must NOT mark the interface down via ifconfig, ip or
# similar. Addresses can be removed, changed and daemons can be stopped, but
# the interface must remain up for wpa_supplicant to work.

if [ -f /etc/gentoo-release ]; then
	EXEC="/etc/init.d/net.${INTERFACE} --quiet"
else
	logger -t wpa_cli "I don't know what to do with this distro!"
	exit 1
fi

case ${ACTION} in
	CONNECTED)
		EXEC="${EXEC} start"
		;;
	DISCONNECTED)
		EXEC="${EXEC} stop"
		;;
	*)
		logger -t wpa_cli "Unknown action ${ACTION}"
		exit 1
		;;
esac

# ${EXEC} can use ${IN_BACKGROUND} so that it knows that the user isn't
# stopping the interface and a background process - like wpa_cli - is.
export IN_BACKGROUND=true

# Removed, since stopping /etc/init.d/net.wlanX stops the network completly.
#logger -t wpa_cli "interface ${INTERFACE} ${ACTION}"
#${EXEC} || logger -t wpa_cli "executing '${EXEC}' failed"
