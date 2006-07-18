#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


depend() {
	use net@extradepend@
}

start() {
	ebegin "Starting pulseaudio"
	HOME=/var/run/pulse

	PA_ALL_OPTS="${PA_OPTS} --fail=1 --daemonize=1 --use-pid-file=0
		    -n -F /etc/pulse/system.pa"
	start-stop-daemon --start --chuid pulse:pulse \
			  --exec /usr/bin/pulseaudio -- ${PA_ALL_OPTS}
	eend $?

	if [[ -S /var/run/pulse/native ]]; then
		chgrp -R pulse-access /var/run/pulse
		chmod 0750 /var/run/pulse
		chmod 0660 /var/run/pulse/native
	fi
}

stop() {
	ebegin "Stopping pulseaudio"
	start-stop-daemon --stop --quiet --exec /usr/bin/pulseaudio
	eend $?
}
