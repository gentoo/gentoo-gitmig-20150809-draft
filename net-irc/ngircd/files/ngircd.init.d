#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ngircd/files/ngircd.init.d,v 1.1 2004/07/08 22:59:54 swegener Exp $

depend() {
	need net
}

start() {
	ebegin "Starting ngIRCd"
	start-stop-daemon --start --quiet --exec /usr/sbin/ngircd
	eend $? "Failed to start ngIRCd"
}

stop() {
	ebegin "Stopping ngIRCd"
	start-stop-daemon --stop --quiet --exec /usr/sbin/ngircd
	eend $? "Failed to stop ngIRCd"
}
