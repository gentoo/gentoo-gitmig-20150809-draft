#!/sbin/runscript
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/files/rsyncd.init.d,v 1.1 2003/02/22 22:41:09 vapier Exp $

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
