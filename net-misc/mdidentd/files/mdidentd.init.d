#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/mdidentd/files/mdidentd.init.d,v 1.2 2003/11/04 03:24:35 vapier Exp $

opts="depend start stop"

depend() {
	need net
}

start() {
	ebegin "Starting mdidentd"
	/usr/sbin/mdidentd -u ${MDIDENTD_UID} -kr /usr/sbin/mdidentd
	eend $?
}

stop() {
	ebegin "Stopping mdidentd"
	kill $(</var/run/mdidentd.pid)
	eend $?
	rm -f /var/run/mdidentd.pid
}
