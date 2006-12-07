#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/files/acpid-1.0.4-init.d,v 1.5 2006/12/07 00:08:44 uberlord Exp $

opts="reload"

depend() {
	need localmount
}

checkconfig() {
	if [[ ! -e /proc/acpi ]] ; then
		eerror "ACPI support has not been compiled into the kernel"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting acpid"
	start-stop-daemon --start --exec /usr/sbin/acpid -- ${ACPID_OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping acpid"
	start-stop-daemon --stop --exec /usr/sbin/acpid
	eend $?
}

reload() {
	ebegin "Reloading acpid configuration"
	start-stop-daemon --stop --oknodo --exec /usr/sbin/acpid --signal HUP
	eend $?
}
