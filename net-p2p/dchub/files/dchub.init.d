#!/sbin/runscript
# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/files/dchub.init.d,v 1.3 2004/07/15 00:19:57 agriffis Exp $

# we define these 4 values here because they're mandatory
DCHUB_CONF="${DCHUB_CONF_DIR}/dchub.conf.db"
DCHUB_USER="${DCHUB_CONF_DIR}/dchub.passwd"
DCHUB_PASS="${DCHUB_CONF_DIR}/dchub.hubpass"
DCHUB_FCRC="${DCHUB_CONF_DIR}/dchub.crc"
DCHUB_REQ="-c ${DCHUB_CONF} -u ${DCHUB_USER} -P ${DCHUB_PASS} -r ${DCHUB_FCRC}"

depend() {
	need net
}

setup() {
	result=0
	if [ ! -e ${DCHUB_CONF} ] ; then
		ebegin "Initializing dchub database"
		dchub --init ${DCHUB_REQ}
		result=$?
		eend ${result}
	fi
	return ${result}
}

start() {
	setup || return 1

	ebegin "Starting direct connect hub..."
	dchub ${DCHUB_REQ} ${DCHUB_OPTS} >& /dev/null &
	result=$?
	echo $!>/var/run/dchub.pid
	eend ${result}
}

stop() {
	ebegin "Stopping direct connect hub..."
	kill `cat /var/run/dchub.pid`
	eend $?
}
