#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/files/klive.init.d,v 1.2 2005/09/12 10:42:38 r3pek Exp $

depend() {
	need net
}

start() {
	ebegin "Starting KLive"
	start-stop-daemon --chuid klive --start --exec /usr/bin/twistd -- --pidfile /tmp/klive.pid --syslog -oy /usr/share/klive/klive.tac
	eend $?
}

stop() {
	ebegin "Stopping KLive"
	start-stop-daemon --stop --pidfile /tmp/klive.pid
	eend $?
}
