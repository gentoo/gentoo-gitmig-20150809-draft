#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2         
# $Header: /var/cvsroot/gentoo-x86/net-misc/howl/files/mDNSResponder.init.d,v 1.3 2004/10/06 23:39:38 latexer Exp $

depend() {
	need nifd
}

start() {
	ebegin "Starting mDNSResponder"
	start-stop-daemon --start --quiet --pidfile /var/run/mDNSResponder.pid \
		--startas /usr/bin/mDNSResponder -- ${MDNSRESPONDER_OPTS}
	eend $? "Failed to start mDNSResponder"
}

stop() {
	ebegin "Stopping mDNSResponder"
	start-stop-daemon --stop --quiet --pidfile /var/run/mDNSResponder.pid
	eend $? "Failed to stop mDNSResponder"

	# clean stale pidfile
	[ -f /var/run/mDNSResponder.pid ] && rm -f /var/run/mDNSResponder.pid
}
