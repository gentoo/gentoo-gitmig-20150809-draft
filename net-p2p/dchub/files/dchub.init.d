#!/sbin/runscript
# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/dchub/files/dchub.init.d,v 1.1 2003/01/26 23:18:33 vapier Exp $

# we define these 2 values here because they're mandatory
DCHUB_CONF="${DCHUB_CONF_DIR}/dchub.conf.db"
DCHUB_PASS="${DCHUB_CONF_DIR}/dchub.passwd"
DCHUB_REQ="-c ${DCHUB_CONF} -u ${DCHUB_PASS}"

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
