#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/files/inspircd-2.0.3-init.d,v 1.1 2011/04/26 14:22:31 c1pher Exp $

opts="${opts} rehash"

depend() {
	need net
	provide ircd
}

start() {
	ebegin "Starting InspIRCd"
	start-stop-daemon --start --quiet --chuid inspircd \
		--exec /usr/bin/inspircd -- \
		--config /etc/inspircd/inspircd.conf \
		--logfile /var/log/inspircd/ircd.log &> /dev/null
	eend $?
}

stop() {
	ebegin "Stopping InspIRCd"
	start-stop-daemon --stop --quiet --exec /usr/bin/inspircd
	eend $?
}

rehash() {
	ebegin "Rehashing InspIRCd"
	/usr/lib/inspircd/inspircd.launcher/inspircd rehash &> /dev/null
	eend $?
}
