#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/files/esound.init.d,v 1.3 2004/02/01 20:32:42 vapier Exp $

# Note: You need to start esound on boot, only if you want to use it over network.

# Warning: To use global esound daemon, you must also set spawn_options
# in /etc/esd/esd.conf to the same protocol (i. e. add "-tcp") and unset
# "Enable sound server startup" in gnome-sound-properties for all users
# and optionally handle authentization.

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
