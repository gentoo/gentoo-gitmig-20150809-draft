#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rsync/files/rsyncd.init.d,v 1.3 2004/07/15 00:11:37 agriffis Exp $

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
