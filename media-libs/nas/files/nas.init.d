#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/files/nas.init.d,v 1.3 2004/07/14 22:42:31 agriffis Exp $

depend() {
	need net
	use alsasound
}

start() {
	ebegin "Starting nas"
	start-stop-daemon --start --quiet --exec /usr/X11R6/bin/nasd --background \
		--pidfile /var/run/nasd.pid --make-pidfile -- $NAS_OPTIONS
	eend $?
}

stop() {
	ebegin "Stopping nas"
	start-stop-daemon --stop --quiet --pidfile /var/run/nasd.pid
	eend $?
}
