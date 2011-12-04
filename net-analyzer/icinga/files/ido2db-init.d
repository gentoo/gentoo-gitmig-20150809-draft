#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/icinga/files/ido2db-init.d,v 1.2 2011/12/04 19:27:46 prometheanfire Exp $

IDO2DBBIN="/usr/sbin/ido2db"
IDO2DBSOCKET="/var/lib/icinga/ido.sock"
IDO2DBLOCK="/var/lib/icinga/ido2db.lock"

function check() {
	if [ -S "${IDO2DBSOCKET}" ] ; then
		ewarn "Strange, the socket file already exist in \"${IDO2DBSOCKET}\""
		ewarn "it will be removed now and re-created by ido2db"
		ewarn "BUT please make your checks."
		rm -f "${IDO2DBSOCKET}"
	fi
}

depend() {
	need net
	use dns logger firewall
	after mysql postgresql
}

start() {
	check
	ebegin "Starting ido2db"
	start-stop-daemon --start --exec ${IDO2DBBIN} --pidfile ${IDO2DBLOCK} --name ${IDO2DBBIN} -- -c ${IDO2DBCFG}
	eend $?
}

stop() {
	ebegin "Stopping ido2db"
	start-stop-daemon --stop --exec ${IDO2DBBIN} --pidfile ${IDO2DBLOCK} --name ${IDO2DBBIN}
	eend $?
}
