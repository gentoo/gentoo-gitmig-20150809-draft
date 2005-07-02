#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/files/acpid-1.0.4-init.d,v 1.1 2005/07/02 18:27:49 brix Exp $

opts="${opts} reload"

depend() {
	need localmount
}

checkconfig() {
	if [ ! -e /proc/acpi ]; then
		eerror "ACPI support has not been compiled into the kernel"
		return 1
	fi
}

start() {
	checkconfig || return 1

	ebegin "Starting acpid"
	start-stop-daemon --start --quiet --exec /usr/sbin/acpid -- \
		-c /etc/acpi/events
	eend ${?}
}

stop() {
	ebegin "Stopping acpid"
	start-stop-daemon --stop --quiet --exec /usr/sbin/acpid
	eend ${?}
}

reload() {
	ebegin "Reloading acpid configuration"
	start-stop-daemon --stop --quiet --exec /usr/sbin/acpid --signal HUP
	eend ${?}
}
