#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/files/folding-init.d,v 1.2 2003/02/27 10:23:31 aliz Exp $

start() {

	ebegin "Starting Folding@home"
	cd /opt/foldingathome
	nice -n 19 ./foldingathome >&/dev/null&
	eend $?
}

stop() {
	ebegin "Stopping Folding@home"
	killall foldingathome
	eend $?
}

