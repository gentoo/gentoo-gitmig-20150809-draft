#!/sbin/runscript
# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

depend() { 
	need net
}

checkconfig() {
        if [ ! -e "${GIMPS_DIR}" ]
        then
                einfo "Creating ${GIMPS_DIR}"
                mkdir "${GIMPS_DIR}"
        fi
}

start() {
        checkconfig
	ebegin "Starting GIMPS"
	nice -n 19 /opt/gimps/mprime -b${GIMPS_CPUS} -w${GIMPS_DIR} ${GIMPS_OPTIONS}
        eend $?
}

stop() {
        ebegin "Stopping GIMPS"
        killall mprime
        eend $?
}
