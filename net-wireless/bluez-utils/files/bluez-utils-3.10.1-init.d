#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bluez-utils/files/bluez-utils-3.10.1-init.d,v 1.1 2007/05/16 12:34:45 betelgeuse Exp $

depend() {
	after coldplug
	need dbus localmount
}

start() {
   	ebegin "Starting Bluetooth"
	local result=0
	HCID_CONFIG="${HCID_CONFIG:-/etc/bluetooth/hcid.conf}"

	if [ -f "${HCID_CONFIG}" ]; then
		ebegin "    Starting hcid"
		# -s enables internal sdp server
		start-stop-daemon --start \
			--exec /usr/sbin/hcid -- -s -f "${HCID_CONFIG}"
		eend $?
	else
		eerror "Can't start hcid because HCID_CONFIG is missing."
	    eend 1
		result=1
	fi

	if [ "${HID2HCI_ENABLE}" = "true" -a -x /usr/sbin/hid2hci ]; then
		ebegin "    Running hid2hci"
		/usr/sbin/hid2hci --tohci -q    #be quiet
		eend $?
		[ "${result}" = "0" ] && result=$?
	fi

	eend ${result}
}

stop() {
	ebegin "Shutting down Bluetooth"

	start-stop-daemon --stop --quiet --exec /usr/sbin/hcid
	eend $?
}
