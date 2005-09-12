#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/files/klive.init.d,v 1.3 2005/09/12 15:49:44 dsd Exp $

depend() {
	need net
}

start() {
	ebegin "Starting KLive"
	start-stop-daemon --start --exec /usr/bin/twistd -- --uid klive --pidfile /var/run/klive.pid --syslog -oy /usr/share/klive/klive.tac
	eend $?
}

stop() {
	# FIXME remove at later date
	start-stop-daemon --stop --pidfile /tmp/klive.pid > /dev/null 2>&1

	ebegin "Stopping KLive"
	start-stop-daemon --stop --pidfile /var/run/klive.pid
	eend $?
}
