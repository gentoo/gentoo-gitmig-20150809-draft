#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/hibernate-script/files/hibernate-script-1.07-init.d,v 1.1 2005/04/30 13:50:42 brix Exp $

depend() {
	after localmount
	before bootmisc
}

start() {
	ebegin "Clearing Software Suspend 2 signatures"
	/sbin/hibernate-cleanup.sh
	eend ${?}
}
