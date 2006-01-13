#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/files/radvd-0.9.1-init.d,v 1.1 2006/01/13 17:45:41 brix Exp $

CONFIGFILE=/etc/radvd.conf
PIDFILE=/var/run/radvd/radvd.pid
SYSCTL_FORWARD=net.ipv6.conf.all.forwarding

depend () {
	need net
}

checkconfig() {
	if [ ! -f ${CONFIGFILE} ]; then
		eerror "Configuration file ${CONFIGFILE} not found"
		return 1
	fi
}

start () {
	checkconfig || return 1

	if [[ ${FORWARD} != "no" ]]; then
		ebegin "Enabling IPv6 forwarding"
		sysctl ${SYSCTL_FORWARD}=1 > /dev/null
		eend ${?}
	fi

	ebegin "Starting IPv6 Router Advertisement Daemon"
	start-stop-daemon --start --quiet --exec /usr/sbin/radvd -- \
		-C ${CONFIGFILE} -p ${PIDFILE} -u radvd ${OPTIONS}
	eend ${?}
}

stop() {
	ebegin "Stopping IPv6 Router Advertisement Daemon"
	start-stop-daemon --stop --quiet --pidfile ${PIDFILE}
	eend ${?}

	if [[ ${FORWARD} != "no" ]]; then
		ebegin "Disabling IPv6 forwarding"
		sysctl ${SYSCTL_FORWARD}=0 > /dev/null
		eend ${?}
	fi
}
