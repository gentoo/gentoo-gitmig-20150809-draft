#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/monkeyd/files/monkeyd.init.d,v 1.1 2003/06/13 18:40:54 vapier Exp $

depend() {
	need net
}

start() {
	ebegin "Starting monkeyd"
	/usr/bin/monkey -D start &>/dev/null
	eend $?
}

stop() {
	ebegin "Stopping monkeyd"
	/usr/bin/monkey stop &>/dev/null
	ret=$?
	eend ${ret}

	if [ ${ret} -ne 0 ] && [ -f ${MONKEY_PID} ] ; then
		ebegin "  Killing monkeyd"
		kill `cat ${MONKEY_PID}` &>/dev/null
		eend $?
		rm -f ${MONKEY_PID} &>/dev/null
	fi
}
