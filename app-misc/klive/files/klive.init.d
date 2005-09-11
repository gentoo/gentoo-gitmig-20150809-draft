#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/klive/files/klive.init.d,v 1.1 2005/09/11 22:54:19 dsd Exp $

depend() {
	need net
}

start() {
	ebegin "Starting KLive"
	/bin/su - klive -c "twistd --syslog --pidfile=/tmp/klive.pid -oy /usr/share/klive/klive.tac" > /dev/null
	eend $?
}

stop() {
	ebegin "Stopping KLive"
	start-stop-daemon --stop --pidfile /tmp/klive.pid
	eend $?
	[[ -e /tmp/klive.pid ]] && rm /tmp/klive.pid
	return 0
}
