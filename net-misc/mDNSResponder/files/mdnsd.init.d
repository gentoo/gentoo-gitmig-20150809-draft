#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mDNSResponder/files/mdnsd.init.d,v 1.1 2005/02/23 21:41:22 motaboy Exp $

start() {
        ebegin "Starting mdnsd"
        start-stop-daemon --start --quiet --pidfile /var/run/mdnsd.pid \
                --startas /usr/sbin/mdnsd
        eend $? "Failed to start mdnsd"
}

stop() {
        ebegin "Stopping mdnsd"
        start-stop-daemon --stop --quiet --pidfile /var/run/mdnsd.pid
        eend $? "Failed to stop mdnsd"

        # clean stale pidfile
        [ -f /var/run/mdnsd.pid ] && rm -f /var/run/mdnsd.pid
}
