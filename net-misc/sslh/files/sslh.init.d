#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslh/files/sslh.init.d,v 1.1 2010/03/05 17:27:40 vapier Exp $

start() {
	ebegin "Starting sslh"
	start-stop-daemon --start \
		--exec /usr/bin/sslh -- ${OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping sslh"
	start-stop-daemon --stop --quiet --retry 20 \
		--pidfile /var/run/sslh.pid
	eend $?
}
