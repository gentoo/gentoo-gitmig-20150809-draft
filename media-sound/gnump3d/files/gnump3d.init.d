#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnump3d/files/gnump3d.init.d,v 1.1 2004/03/30 18:46:34 eradicator Exp $

depend() {
	need net
}

start() {
	ebegin "Starting gnump3d"
	start-stop-daemon --start --quiet --exec /usr/bin/gnump3d2 --make-pidfile \
		--pidfile /var/run/gnump3d.pid --background -- --quiet
	eend $?
}

stop() {
	ebegin "Stopping gnump3d"
	start-stop-daemon --stop --quiet --pidfile /var/run/gnump3d.pid
	eend $?
}

