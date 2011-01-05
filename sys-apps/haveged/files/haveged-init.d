#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/haveged/files/haveged-init.d,v 1.1 2011/01/05 03:30:30 robbat2 Exp $

DAEMON=haveged
HAVEGED_OPTS="-r 0 ${HAVEGED_OPTS}"
PIDFILE=/var/run/${DAEMON}.pid

start() {
	ebegin "Starting ${DAEMON}"
	start-stop-daemon --start --quiet --exec "/usr/sbin/${DAEMON}" -- ${HAVEGED_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping ${DAEMON}"
	start-stop-daemon --stop --quiet --pidfile "${PIDFILE}"
	eend $?
}

# vim:ft=gentoo-init-d:
