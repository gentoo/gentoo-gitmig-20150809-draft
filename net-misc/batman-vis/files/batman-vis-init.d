#!/sbin/runscript

depend() {
	need net
}

start() {
	ebegin "Starting batman-vis"
	start-stop-daemon --start --quiet --exec /usr/sbin/batman-vis -- ${VIS_OPTIONS} ${VIS_BATMAN_INTERFACES} ${VIS_DOT_INTERFACES}
	eend $?
}

stop() {
	ebegin "Stopping batman-vis"
	start-stop-daemon --stop --quiet --exec /usr/sbin/batman-vis
	eend $?
}
