#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/kismet/files/kismet-2005.04.1-init.d,v 1.1 2005/04/03 11:06:39 brix Exp $

# If you use this init script, you only need to run `kismet_client` to connect

checkconfig() {
	if [ ! -e /etc/kismet.conf ] ; then
		eerror "You need an /etc/kismet.conf to run kismet_server."
		return 1
	elif [ -z "${WIFI_DEV}" ]; then
		eerror "You must define WIFI_DEV in /etc/conf.d/kismet."
		return 1
	fi

}
checkcard() {
	if [ -z "`cat /proc/net/dev | grep ${WIFI_DEV}`" ]; then
		eerror "${WIFI_DEV} not found."
		return 1
	fi
}

start() {
	checkconfig || return 1
	checkcard || return 1
	ifconfig ${WIFI_DEV} up
	ebegin "Starting kismet_server"
	start-stop-daemon --start --quiet --pidfile /var/run/kismet_server.pid \
		--background --make-pidfile --exec /usr/bin/kismet_server -- ${KISMET_SERVER_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping kismet_server"
	start-stop-daemon --stop --quiet --pidfile /var/run/kismet_server.pid
	kismet_unmonitor &> /dev/null
	eend $?
}

