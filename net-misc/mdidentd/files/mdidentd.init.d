#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mdidentd/files/mdidentd.init.d,v 1.3 2004/03/06 03:36:03 vapier Exp $

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
