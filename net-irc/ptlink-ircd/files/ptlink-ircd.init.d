#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-ircd/files/ptlink-ircd.init.d,v 1.1 2004/07/10 22:24:03 swegener Exp $

depend() {
	need net
	use dns
}

start() {
	ebegin "Starting ptlink-ircd"
	start-stop-daemon --start --quiet --exec /usr/bin/ptlink-ircd \
		--chuid ${PTLINKIRCD_USER} -- -l /var/lib/ptlink-ircd \
		-e /etc/ptlink-ircd >/dev/null
	eend $?
}

stop() {
	ebegin "Shutting down ptlink-ircd"
	start-stop-daemon --stop --pidfile /var/lib/ptlink-ircd/ircd.pid
	eend $?
}
