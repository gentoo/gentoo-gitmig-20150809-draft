#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ptlink-opm/files/ptlink-opm.init.d,v 1.2 2004/07/10 23:12:10 swegener Exp $

depend() {
	need net
	use dns
	provide ircd
}

start() {
	ebegin "Starting ptlink-opm"
	start-stop-daemon --start --quiet --exec /usr/bin/ptlink-opm \
		--chuid ${PTLINKOPM_USER} >/dev/null
	eend $?
}

stop() {
	ebegin "Shutting down ptlink-opm"
	start-stop-daemon --stop --exec /usr/bin/ptlink-opm
	eend $?
}
