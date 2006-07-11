#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


depend() {
	use net@extradepend@
}

start() {
	ebegin "Starting pulseaudio"
	start-stop-daemon --start --quiet --background --exec /usr/bin/pulseaudio -- $PULSEAUDIO_START $PULSEAUDIO_OPTIONS
	eend $?
}

stop() {
	ebegin "Stopping pulseaudio"
	start-stop-daemon --stop --quiet --exec /usr/bin/pulseaudio
	eend $?
}
