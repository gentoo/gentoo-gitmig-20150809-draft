#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/clrngd/files/clrngd-init.d,v 1.1 2004/01/04 23:20:13 robbat2 Exp $

DAEMON=clrngd
OPTS=${DELAYTIME}

start() {
	ebegin "Starting ${DAEMON}"
	start-stop-daemon --start --quiet --exec /usr/sbin/${DAEMON} ${OPTS}
	eend $?
}

stop() {
	ebegin "Stopping ${DAEMON}"
	start-stop-daemon --stop --quiet --exec /usr/sbin/${DAEMON}
	eend $?
}

# vim: ts=4 sw=4 ft=sh:
