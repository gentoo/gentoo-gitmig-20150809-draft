#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/monkeyd/files/monkeyd.init.d,v 1.3 2005/02/20 22:47:11 vapier Exp $

depend() {
	use net
}

start() {
	ebegin "Starting monkeyd"
	/usr/bin/monkey -D &> /dev/null
	eend $?
}

stop() {
	ebegin "Stopping monkeyd"
	start-stop-daemon --stop --quiet --pidfile ${MONKEY_PID}
	ret=$?
	rm -f ${MONKEY_PID}
	eend ${ret}
}
