#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/files/watchdog-5.2.4_p5-init.d,v 1.1 2005/11/27 10:14:24 brix Exp $

depend() {
	need localmount
	use logger
}

start() {
	ebegin "Starting watchdog"
	start-stop-daemon --start --quiet --exec /usr/sbin/watchdog \
		-- ${WATCHDOG_OPTS}
	eend ${?}
}

stop() {
	ebegin "Stopping watchdog"
	start-stop-daemon --stop --quiet --exec /usr/sbin/watchdog
	eend ${?}
}
