#!/sbin/runscript

depend() {
	need net
}

start() {
	ebegin "Starting batman"
	start-stop-daemon --start --quiet --exec /usr/sbin/batmand -- ${BATMAN_OPTIONS} ${BATMAN_INTERFACES}
	eend $?
}

stop() {
	ebegin "Stopping batman"
	start-stop-daemon --stop --quiet --exec /usr/sbin/batmand
	eend $?
}
