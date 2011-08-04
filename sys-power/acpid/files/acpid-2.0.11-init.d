#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/files/acpid-2.0.11-init.d,v 1.3 2011/08/04 17:30:01 ssuominen Exp $

extra_commands="reload"

depend() {
	need localmount
	use logger
}

start() {
	ebegin "Starting acpid"
	start-stop-daemon --start --quiet --exec /usr/sbin/acpid -- ${ACPID_OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping acpid"
	start-stop-daemon --stop --exec /usr/sbin/acpid
	eend $?
}

reload() {
	ebegin "Reloading acpid configuration"
	start-stop-daemon --exec /usr/sbin/acpid --signal HUP
	eend $?
}
