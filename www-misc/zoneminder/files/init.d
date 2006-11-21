#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/zoneminder/files/init.d,v 1.2 2006/11/21 22:36:05 rl03 Exp $

start() {
	ebegin "Starting zoneminder"
	${CMD_START}
	eend $?
}

stop() {
	ebegin "Stopping zoneminder"
	${CMD_STOP}
	eend $?
}
