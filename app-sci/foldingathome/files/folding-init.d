#!/sbin/runscript
# Copyright 1999-2003 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/foldingathome/files/folding-init.d,v 1.5 2004/07/09 21:42:18 mr_bones_ Exp $

start() {

	ebegin "Starting Folding@home"
	cd /opt/foldingathome
	nice -n 19 ./foldingathome >&/dev/null&
	eend $?
}

stop() {
	ebegin "Stopping Folding@Home"
	cd /opt/foldingathome
	for I in FahCore*.exe
	do
		killall -q $I >/dev/null
	done
	killall foldingathome >/dev/null
	eend $?
}

