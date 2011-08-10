#!/sbin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeboxserver/files/squeezeboxserver.init.d,v 1.7 2011/08/10 23:58:34 lavajoe Exp $

# These fit the Squeezebox Server ebuild and so shouldn't need to be changed;
# user-servicable parts go in /etc/conf.d/squeezeboxserver.
pidfile=/var/run/squeezeboxserver/squeezeboxserver.pid
logdir=/var/log/squeezeboxserver
varlibdir=/var/lib/squeezeboxserver
cachedir=${varlibdir}/cache
prefsdir=/etc/squeezeboxserver/prefs
prefsfile=/etc/squeezeboxserver/squeezeboxserver.prefs
scuser=squeezeboxserver
scname=squeezeboxserver

depend() {
	need net
	use mysql
}

start() {
	ebegin "Starting Squeezebox Server"

	cd /
	start-stop-daemon \
		--start --exec /usr/sbin/${scname} \
		--pidfile ${pidfile} \
		--user ${scuser} \
		--background \
		-- \
		--quiet \
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
	start-stop-daemon --retry 10 --stop --pidfile ${pidfile}
	eend $? "Failed to stop Squeezebox Server"
}
