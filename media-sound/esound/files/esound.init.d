#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/files/esound.init.d,v 1.1 2003/05/29 22:36:51 utx Exp $

# Note: You need to start esound on boot, only if you want to use it over network.

. /etc/conf.d/esound

depend() {
	use net@extradepend@
}

start() {
	ebegin "Starting esound"
	start-stop-daemon --start --quiet --background --exec /usr/bin/esd -- $ESD_START $ESD_OPTIONS
	eend $?
}

stop() {
	ebegin "Stopping esound"
	start-stop-daemon --stop --quiet --exec /usr/bin/esd
	eend $?
}
