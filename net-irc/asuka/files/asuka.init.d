#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/asuka/files/asuka.init.d,v 1.1 2003/10/27 19:55:17 zul Exp $

opts="depend start stop"

depend() {
	need net
}

start() {
	ebegin "Starting asuka-ircd"
	start-stop-daemon --start --quiet --chuid $ASUKA_UID --exec /usr/bin/asuka-ircd
	eend $? "Failed to start asuka-ircd"
}

stop() {
	ebegin "Stopping asuka-ircd"
	start-stop-daemon --stop --quiet --exec /usr/bin/asuka-ircd
	eend $? "Failed to stop asuka-ircd"
}
