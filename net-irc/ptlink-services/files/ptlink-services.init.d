#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-services/files/ptlink-services.init.d,v 1.2 2004/07/10 23:16:14 swegener Exp $

depend() {
	need net
	use dns ircd
}

start() {
	ebegin "Starting ptlink-services"
	start-stop-daemon --start --quiet --exec /usr/bin/ptlink-services \
		--chuid ${PTLINKSERVICES_USER} >/dev/null
	eend $?
}

stop() {
	ebegin "Shutting down ptlink-services"
	start-stop-daemon --stop --exec /usr/bin/ptlink-services
	eend $?
}
