#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miniupnpd/files/miniupnpd-20090129-init.d,v 1.1 2009/01/30 00:05:17 gurligebis Exp $

depend() {
	need net iptables
}

start() {
	ebegin "Starting miniupnpd"
	/etc/miniupnpd/iptables_init.sh
	start-stop-daemon --start --pidfile /var/run/miniupnpd.pid --startas /usr/sbin/miniupnpd -- ${ARGS}
	eend $?
}

stop() {
	ebegin "Stopping miniupnpd"
        start-stop-daemon --stop --pidfile /var/run/miniupnpd.pid
	eend $?
	/etc/miniupnpd/iptables_removeall.sh
}
