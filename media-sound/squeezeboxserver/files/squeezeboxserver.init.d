#!/sbin/runscript
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeboxserver/files/squeezeboxserver.init.d,v 1.1 2009/11/25 22:52:25 lavajoe Exp $

# These fit the Squeezebox Server ebuild and so shouldn't need to be changed;
# user-servicable parts go in /etc/conf.d/squeezeboxserver.
pidfile=/var/run/squeezeboxserver/squeezeboxserver.pid
logdir=/var/log/squeezeboxserver
varlibdir=/var/lib/squeezeboxserver
prefsdir=${varlibdir}/prefs
cachedir=${varlibdir}/cache
prefsfile=${prefsdir}/squeezeboxserver.prefs
scuser=squeezeboxserver
scname=squeezeboxserver

depend() {
	need net mysql
}

start() {
	ebegin "Starting Squeezebox Server"

	cd /
	start-stop-daemon \
		--start --exec /usr/bin/perl /usr/sbin/${scname} \
		--pidfile ${pidfile} \
		--startas /usr/sbin/${scname} \
		--chuid ${scuser} \
		-- \
		--quiet --daemon \
		--pidfile=${pidfile} \
		--cachedir=${cachedir} \
		--prefsfile=${prefsfile} \
		--prefsdir=${prefsdir} \
		--logdir=${logdir} \
		--audiodir=${SBS_MUSIC_DIR} \
		--playlistdir=${SBS_PLAYLISTS_DIR} \
		${SBS_OPTS}

	eend $? "Failed to start Squeezebox Server"
}

stop() {
	ebegin "Stopping Squeezebox Server"
	start-stop-daemon -o --stop --pidfile ${pidfile}
	eend $? "Failed to stop Squeezebox Server"
}
