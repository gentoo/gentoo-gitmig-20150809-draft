#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-server/files/silc-server.init.d,v 1.1 2004/07/15 21:36:02 swegener Exp $

depend() {
	need net
	use dns
}

start() {
	ebegin "Starting silc-server"
	start-stop-daemon --start --quiet --exec /usr/sbin/silcd -- -f /etc/silc-server/silcd.conf
	eend $?
}

stop() {
	ebegin "Shutting down silc-server"
	start-stop-daemon --stop --pidfile /var/run/silcd.pid
	eend $?
}
