#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/bopm/files/bopm.init.d,v 1.1 2004/02/18 00:43:59 zul Exp $

opts="depend start stop"

depend() {
	need net
}

start() {
	ebegin "Starting Blitzed Open Proxy Monitor"
	start-stop-daemon --start --quiet --chuid ${BOPM_UID} --exec /usr/bin/bopm
	eend $?
}

stop() {
	ebegin "Stopping Blitzed Open Proxy Monitor"
	kill $(</var/run/bopm/bopm.pid)
	eend $?
	rm -f /var/run/bopm/bopm.pid
}
