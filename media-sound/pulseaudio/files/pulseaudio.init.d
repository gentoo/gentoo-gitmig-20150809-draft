#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


depend() {
	use net@extradepend@
}

start() {
	ebegin "Starting pulseaudio"
	# -D0 -> don't daemonize, leave that to s-s-d
	start-stop-daemon --start --quiet --background --exec /usr/bin/pulseaudio -- $PULSEAUDIO_OPTIONS --fail=true -D0
	eend $?
}

stop() {
	ebegin "Stopping pulseaudio"
	start-stop-daemon --stop --quiet --exec /usr/bin/pulseaudio
	eend $?
}
