#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/files/pmacctd-init.d,v 1.6 2012/04/13 15:54:38 jer Exp $

PMACCTDDIR=${PMACCTDDIR:-/etc/pmacctd}
if [ ${SVCNAME} != "pmacctd" ]; then
	PMACCTDPID="/var/run/${SVCNAME}.pid"
else
	PMACCTDPID="/var/run/pmacctd.pid"
fi
PMACCTDCONF="${PMACCTDDIR}/${SVCNAME}.conf"

depend() {
	need net
}

checkconfig() {
	if [ ! -e ${PMACCTDCONF} ] ; then
		eerror "You need an ${PMACCTDCONF} file to run pmacctd"
		return 1
	fi
}

start() {
	checkconfig || return 1
	ebegin "Starting ${SVCNAME}"
	start-stop-daemon --start --pidfile "${PMACCTDPID}" --exec /usr/sbin/pmacctd \
		-- -D -f "${PMACCTDCONF}" -F "${PMACCTDPID}" ${OPTS}
	eend $?
}

stop() {
	ebegin "Stopping ${SVCNAME}"
	start-stop-daemon --stop --pidfile "${PMACCTDPID}" --exec /usr/sbin/pmacctd
	eend $?
}
