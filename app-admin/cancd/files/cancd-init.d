#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cancd/files/cancd-init.d,v 1.1 2005/11/14 21:15:54 robbat2 Exp $

depend() {
	need net
}

start() {
	mkdir -p ${CRASH_DIR}
	chown ${CHUID} ${CRASH_DIR}
	chmod 700 ${CRASH_DIR}
	ebegin "Starting cancd"
	start-stop-daemon --start --quiet --chuid ${CHUID} --exec /usr/sbin/cancd  -- -p ${CANCD_PORT} -l "${CRASH_DIR}" -o "${CRASH_FORMAT}"
	eend ${?}
}

stop() {
	ebegin "Stopping cancd"
	start-stop-daemon --stop --quiet --exec /usr/sbin/cancd
	eend ${?}
}
