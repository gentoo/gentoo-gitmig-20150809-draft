#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/files/rsyncd.init.d,v 1.2 2004/05/02 22:45:02 mholzer Exp $

depend() {
	use net
}

start() {
	ebegin "Starting rsyncd"
	rsync --daemon ${RSYNC_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping rsyncd"
	kill `cat /var/run/rsyncd.pid`
	eend $?
}
