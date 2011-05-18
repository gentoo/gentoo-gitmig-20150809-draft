#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/files/sysstat.init.d,v 1.3 2011/05/18 02:21:33 jer Exp $

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
