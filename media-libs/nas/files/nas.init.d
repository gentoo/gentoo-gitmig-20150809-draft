#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/files/nas.init.d,v 1.1 2004/03/26 17:04:51 eradicator Exp $

depend() {
	need net
	use alsasound
}

start() {
	ebegin "Starting nas"
	start-stop-daemon --start --quiet --exec /usr/X11R6/bin/nasd -- -b $NAS_OPTIONS
	eend $?
}

stop() {
	ebegin "Stopping nas"
	start-stop-daemon --stop --quiet --exec /usr/X11R6/bin/nasd
	eend $?
}
