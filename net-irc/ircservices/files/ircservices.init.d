#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircservices/files/ircservices.init.d,v 1.2 2004/08/14 22:35:49 swegener Exp $

depend() {
	need net
	use ircd
}

start() {
	ebegin "Starting IRC Services"
	/usr/bin/ircservices \
		-dir=/var/lib/ircservices \
		-log=/var/log/ircservices/ircservices.log \
		&>/dev/null
	eend $?
}

stop() {
	ebegin "Stopping IRC Services"
	start-stop-daemon --stop --quiet --pidfile /var/lib/ircservices/ircservices.pid
	eend $?
	rm -f /var/lib/ircservices/ircservices.pid
}
