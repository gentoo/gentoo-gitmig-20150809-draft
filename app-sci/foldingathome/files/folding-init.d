#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/files/folding-init.d,v 1.3 2003/04/23 08:20:25 aliz Exp $

start() {

	ebegin "Starting Folding@home"
	cd /opt/foldingathome
	nice -n 19 ./foldingathome >&/dev/null&
	eend $?
}

stop() {
	ebegin "Stopping Folding@home"
	killall FahCore_78.exe > /dev/null
	if ! $? ; then
		killall foldingathome
	fi
	eend $?
}
