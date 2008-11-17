#!/sbin/runscript
# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/symon/files/symux-init.d,v 1.2 2008/11/17 00:00:46 tcunha Exp $

opts="${opts} reload"

depend() {
	after bootmisc
	need localmount net
	use logger
}

reload() {
	ebegin "Reloading symux"
	start-stop-daemon --stop --pidfile /var/run/symux.pid \
		--exec /usr/sbin/symux --oknodo --signal HUP
	eend $?
}

start() {
	ebegin "Starting symux"
	start-stop-daemon --start --exec /usr/sbin/symux
	eend $?
}

stop() {
	ebegin "Stopping symux"
	start-stop-daemon --stop --pidfile /var/run/symux.pid
	eend $?
}
