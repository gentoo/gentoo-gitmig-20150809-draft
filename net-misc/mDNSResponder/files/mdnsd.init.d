#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/files/mdnsd.init.d,v 1.3 2011/10/23 18:15:50 polynomial-c Exp $

extra_started_commands="reload dump"

depend() {
	after net
}

start() {
	ebegin "Starting mdnsd"
	start-stop-daemon --start --quiet --pidfile /var/run/mdnsd.pid \
		--exec /usr/sbin/mdnsd

	eend $? "Failed to start mdnsd"
}

stop() {
	ebegin "Stopping mdnsd"
	start-stop-daemon --stop --quiet --pidfile /var/run/mdnsd.pid
	eend $? "Failed to stop mdnsd"
}

reload() {
	ebegin "Reloading mdnsd"
	kill -HUP `cat /var/run/mdnsd.pid` >/dev/null 2>&1
	eend $? "Failed to reload mdnsd"
}

dump() {
	ebegin "Dump mdnsd state to logs"
	kill -USR1 `cat /var/run/mdnsd.pid` >/dev/null 2>&1
	eend $? "Failed to dump mdnsd state"
}
