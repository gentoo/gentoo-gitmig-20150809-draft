#!/sbin/runscript
# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezecenter/files/squeezecenter-7.0.init.d,v 1.1 2008/01/07 01:33:35 lavajoe Exp $

# These fit the SqueezeCenter ebuild and so shouldn't need to be changed;
# user-servicable parts go in /etc/conf.d/squeezecenter.
pidfile=/var/run/squeezecenter/squeezecenter.pid
logdir=/var/log/squeezecenter
cachedir=/var/cache/squeezecenter
prefsdir=${cachedir}/prefs
prefsfile=/etc/squeezecenter.prefs
scdir=/opt/squeezecenter
scuser=squeezecenter

depend() {
	need net mysql
}

start() {
	ebegin "Starting SqueezeCenter"

	cd /
	/usr/bin/nice --adjustment=${SC_NICENESS:-0} sudo -u ${scuser} \
		start-stop-daemon \
			--start --quiet \
			--exec ${scdir}/slimserver.pl -- \
			--quiet --daemon \
			--pidfile=${pidfile} \
			--cachedir=${cachedir} \
			--prefsfile=${prefsfile} \
			--prefsdir=${prefsdir} \
			--logdir=${logdir} \
			--audiodir=${SC_MUSIC_DIR} \
			--playlistdir=${SC_PLAYLISTS_DIR} \
			${SC_OPTS}

	eend $? "Failed to start SqueezeCenter"
}

stop() {
	ebegin "Stopping SqueezeCenter"
	start-stop-daemon -o --stop --quiet --pidfile ${pidfile}
	eend $? "Failed to stop SqueezeCenter"
}
