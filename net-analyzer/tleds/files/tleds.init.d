#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tleds/files/tleds.init.d,v 1.1 2004/01/08 05:29:35 vapier Exp $


depend() {
	need net
}

start() {
	ebegin "Starting tleds"
	/usr/sbin/tleds -d ${DELAY} ${IFACE} ${EXTRA_OPTS} > /dev/null
	eend $?
}

stop() {
	ebegin "Stopping tleds"
	/usr/sbin/tleds -k > /dev/null
	eend $?
}

