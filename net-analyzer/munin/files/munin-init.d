#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/files/munin-init.d,v 1.1 2006/07/11 09:18:47 robbat2 Exp $

NAME="munin-node"
PIDFILE=/var/run/munin/$NAME.pid

depend() {
	need net
	after cron
}

start() {
	ebegin "Starting $NAME"
	start-stop-daemon --quiet --start --pidfile $PIDFILE --exec /usr/sbin/$NAME
	eend $?
}

stop() {
	ebegin "Stopping $NAME"
	start-stop-daemon --quiet --stop --pidfile $PIDFILE
	eend $?
}

# vim: filetype=gentoo-init-d:
