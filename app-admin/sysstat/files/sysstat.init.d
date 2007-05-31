#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/files/sysstat.init.d,v 1.1 2007/05/31 10:08:50 jokey Exp $

depend() {
    use hostname
}

start() {
    ebegin "Calling the system activity data collector (sadc)..."
    /usr/lib/sa/sadc -F -L -
    eend $?
}

stop() {
    ebegin "Stopping..."
    eend $?
}

# restart emulation
# svc_start svc_stop
restart() {
    ebegin "Restart..."
    eend $?
}
