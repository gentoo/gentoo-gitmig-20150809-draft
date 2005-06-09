#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vde/files/vde.init.d,v 1.1 2005/06/09 22:34:46 rphillips Exp $

depend() {
	before net
}


start() {
	ebegin "Starting vde"
	modprobe tun
	start-stop-daemon --start --quiet \
		--exec /usr/bin/vde_switch -- -tap tap0 -daemon
	eend $? "Failed to start vde"
}

stop() {
	ebegin "Stopping vde"
	start-stop-daemon --stop --quiet --exec /usr/bin/vde_switch
	rmmod tun
	eend $? "Failed to stop vde"
}
