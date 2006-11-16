#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/slimserver/files/slimserver.init.d,v 1.2 2006/11/16 12:27:44 twp Exp $

SLIMSERVER_PIDFILE="/var/run/slimserver/slimserver.pid"

depend() {
	#need mysql
	need net
}

start() {
	local myopts=""
	[[ -n "${SLIMSERVER_AUDIODIR}" ]] \
		&& myopts="${myopts} --audiodir ${SLIMSERVER_AUDIODIR}"
	[[ -n "${SLIMSERVER_PLAYLISTDIR}" ]] \
		&& myopts="${myopts} --playlistdir ${SLIMSERVER_PLAYLISTDIR}"
	ebegin "Starting slimserver"
	HOME=/opt/slimserver start-stop-daemon --start \
		--exec /opt/slimserver/slimserver.pl \
		--pidfile ${SLIMSERVER_PIDFILE} \
		-- \
		--cachedir /var/cache/slimserver \
		--daemon \
		--group slimserver \
		--logfile /var/log/slimserver \
		--pidfile ${SLIMSERVER_PIDFILE} \
		--prefsfile "${SLIMSERVER_PREFSFILE:-/etc/slimserver.pref}" \
		--user slimserver \
		--quiet \
		${myopts} ${SLIMSERVER_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping slimserver"
	start-stop-daemon --stop \
		--quiet \
		--pidfile ${SLIMSERVER_PIDFILE}
	eend $?
}
