#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2         
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/files/mDNSResponder.init.d,v 1.1 2003/12/27 16:25:28 lisa Exp $

depend() {
	use nifd
}

start() {
	ebegin "Starting mDNSResponder"
	start-stop-daemon --start --quiet --pidfile /var/run/mDNSResponder.pid \
		--startas /usr/bin/mDNSResponder ${MDNSRESPONDER_OPTS}
	eend $? "Failed to start mDNSResponder"
}

stop() {
	ebegin "Stopping mDNSResponder"
	start-stop-daemon --stop --quiet --pidfile /var/run/mDNSResponder.pid
	eend $? "Failed to stop mDNSResponder"

	# clean stale pidfile
	[ -f /var/run/mDNSResponder.pid ] && rm -f /var/run/mDNSResponder.pid
}
