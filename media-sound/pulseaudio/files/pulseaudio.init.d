#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


depend() {
	use net@extradepend@
}

start() {
	ebegin "Starting pulseaudio"
	HOME=/var/run/pulse
	start-stop-daemon --start --chuid pulse:pulse \
			  --exec /usr/bin/pulseaudio -- ${PA_OPTS} --fail=true -D
	eend $?

	chgrp -R audio /var/run/pulse
	chmod 0750 /var/run/pulse
	chmod 0660 /var/run/pulse/native
}

stop() {
	ebegin "Stopping pulseaudio"
	start-stop-daemon --stop --quiet --exec /usr/bin/pulseaudio
	eend $?
}
