#!/sbin/runscript

start() {

	ebegin "Starting Folding@home"
	cd /opt/foldingathome
	./foldingathome >&/dev/null&
	eend $?
}

stop() {
	ebegin "Stopping Folding@home"
	killall foldingathome
	eend $?
}

