#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

depend() {
	need net
}

checkconfig() {
	if [ ! -e "${GIMPS_DIR}" ]; then
		einfo "Creating ${GIMPS_DIR}"
		/bin/mkdir "${GIMPS_DIR}"
	fi

	/bin/chown -R ${USER}:${GROUP} ${GIMPS_DIR}
}

start() {
	checkconfig
	ebegin "Starting GIMPS"
	start-stop-daemon --quiet --start --exec /opt/gimps/mprime \
			--chdir ${GIMPS_DIR} --chuid ${USER}:${GROUP} \
			-- -b${GIMPS_CPUS} -w${GIMPS_DIR} ${GIMPS_OPTIONS}
	eend $?
}

stop() {
	ebegin "Stopping GIMPS"
	start-stop-daemon --quiet --stop --exec /opt/gimps/mprime
	eend $?
}
