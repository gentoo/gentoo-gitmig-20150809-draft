#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wpa_supplicant/files/wpa_supplicant-0.2.5-init.d,v 1.1 2004/12/10 15:45:32 brix Exp $

depend() {
	before net
}

start() {
	ebegin "Starting wpa_supplicant"

	if [ ! -f /etc/wpa_supplicant.conf ]; then
		eerror "Configuration file /etc/wpa_supplicant.conf not found"
		return 1
	fi

	if [ -z "$INTERFACES" ]; then
		eerror "No interfaces specified in /etc/conf.d/wpa_supplicant"
		return 1
	fi

	for IFACE in $INTERFACES; do
		ebegin " ${IFACE}"

		eval ARGS_IFACE=\"\$\{ARGS_$IFACE\}\"

		/sbin/ifconfig ${IFACE} up

		start-stop-daemon --start --quiet --exec /usr/sbin/wpa_supplicant \
			 -- -B -i${IFACE} -c/etc/wpa_supplicant.conf ${ARGS} ${ARGS_IFACE}
		eend $?
	done
}

stop() {
	ebegin "Stopping wpa_supplicant"

	start-stop-daemon --stop --quiet --exec /usr/sbin/wpa_supplicant
	eend ${?}
}

