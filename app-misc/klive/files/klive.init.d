#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/files/klive.init.d,v 1.4 2007/04/14 23:11:29 masterdriverz Exp $

depend() {
	need net
}

start() {
	ebegin "Starting KLive"
	start-stop-daemon --start --name twistd --exec /usr/bin/twistd -- --uid klive --pidfile /var/run/klive.pid --syslog -oy /usr/share/klive/klive.tac
	eend $?
}

stop() {
	ebegin "Stopping KLive"
	start-stop-daemon --stop --name twistd --pidfile /var/run/klive.pid
	eend $?
}
