#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rarpd/files/rarpd.init.d,v 1.3 2004/07/15 00:10:49 agriffis Exp $

depend() {
	need net
}

checkconfig() {
	if [ ! -f /etc/ethers ] ; then
		eerror "Please create /etc/ethers with the following content:"
		eerror "[MAC address] [name or IP]"
		return 1
	fi
	return 0
}

start() {
	checkconfig || return 1

	ebegin "Starting rarpd"
	/usr/sbin/rarpd ${RARPD_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping rarpd"
	kill $(</var/run/rarpd.pid)
	eend $?
	rm -f /var/run/rarpd.pid
}
