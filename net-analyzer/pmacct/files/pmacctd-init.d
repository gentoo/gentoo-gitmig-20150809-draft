#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/files/pmacctd-init.d,v 1.2 2004/07/14 23:08:10 agriffis Exp $

depend() {
	need net
}

chekconfig() {
	if [ ! -e /etc/pmacctd.conf ] ; then
		eerror "You need an /etc/pmacctd.conf file to run pmacctd"
		return 1
	fi
}

start() {
	chekconfig || return 1
	ebegin "Starting pmacctd"
	start-stop-daemon --start --exec /usr/sbin/pmacctd \
		-- -D -f /etc/pmacctd.conf -i ${INTERFACE} ${OPTS}

	# pmacctd apparently always returns a value > 0 when launched,
	# and start-stop-daemon sees that an error an therfore always
	# return 1. So we have to assume everything whent as expected.
	
	eend
}

stop() {
	ebegin "Stopping pmacctd"
	start-stop-daemon --stop --exec /usr/sbin/pmacctd
	eend $?
}

