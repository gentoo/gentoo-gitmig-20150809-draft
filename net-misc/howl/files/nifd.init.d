#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2         
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/files/nifd.init.d,v 1.1 2003/12/27 16:25:28 lisa Exp $

start() {
	ebegin "Starting nifd"
	start-stop-daemon --start --quiet --pidfile /var/run/nifd.pid \
		--startas /usr/bin/nifd ${NIFD_OPTS}
	eend $? "Failed to start nifd"
}

stop() {
	ebegin "Stopping nifd"
	start-stop-daemon --stop --quiet --pidfile /var/run/nifd.pid
	eend $? "Failed to stop nifd"

	# clean stale pidfile
	[ -f /var/run/nifd.pid ] && rm -f /var/run/nifd.pid
}
