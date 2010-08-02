#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/files/sysstat.init.d,v 1.2 2010/08/02 16:17:38 jer Exp $

depend() {
    use hostname
}

start() {
    ebegin "Writing a dummy startup record using sadc (see sadc(8))..."
    /usr/lib/sa/sadc -F -L -
    eend $?
}

stop() {
    ebegin "Cannot stop writing a dummy startup record (see sadc(8))..."
    eend $?
}

# restart emulation
# svc_start svc_stop
restart() {
    ebegin "Not writing yet another dummy startup record (see sadc(8))..."
    eend $?
}
