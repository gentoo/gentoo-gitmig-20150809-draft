#!/bin/sh
# Copyright 1999-2006 Gentoo Foundation
# Written by Roy Marples <uberlord@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# Alternatively, this file may be distributed under the terms of the BSD License
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/files/wpa_supplicant-0.5.3-wpa_cli.sh,v 1.1 2006/04/29 14:28:48 brix Exp $

if [ -z "$1" -o -z "$2" ]; then
	echo "Insufficient parameters" > /dev/stderr
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
	echo "I don't know what to do with this distro!" > /dev/stderr
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
		echo "Unknown action ${ACTION}" > /dev/stderr
		exit 1
		;;
esac

# ${EXEC} can use ${IN_BACKGROUND} so that it knows that the user isn't
# stopping the interface and a background process - like wpa_cli - is.
export IN_BACKGROUND=true

${EXEC}
