#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Author: Michael v.Ostheim <MvOstheim@web.de>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo/files/mondo.sh,v 1.2 2003/02/14 23:26:16 vapier Exp $

depend() {
	need modules
}

start() {
	ebegin "Starting mondo"

	if [ -z "$(cat /proc/sys/dev/sensors/chips)" ] ; then
		eend 1 "You need to setup lm_sensors first"
		return 1
	fi

	start-stop-daemon --start --quiet --exec /usr/sbin/mondo \
			-- -c /etc/mondo.conf -s /etc/sensors.conf
	eend ${?}
}

stop() {
	ebegin "Stopping mondo"
	start-stop-daemon --stop --quiet --pidfile /var/run/mondo.pid
	eend ${?}
}
