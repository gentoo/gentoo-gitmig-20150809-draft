#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later

opts="start stop restart"
	
SERVERPID="/usr/spool/PBS/server_priv/server.lock"
MOMPID="/usr/spool/PBS/mom_priv/mom.lock"
SCHEDULER="${PBS_SCHEDULER:=pbs_sched}"
SCHEDPATH="`which ${SCHEDULER}`"
SCHEDFILE="`basename ${SCHEDPATH}`"
SCHEDPID="${PBS_SCHEDULER_PID:=/usr/spool/PBS/sched_priv/sched.lock}"

depend() {
	need net
}

checkconfig() {

	HOSTNAME="`hostname`"

	if [ ! -e /usr/spool/PBS/server_name ] ; then
		eerror "Missing config file /usr/spool/PBS/server_name"
		return 1
	else
		PBS_SERVER_NAME="`cat /usr/spool/PBS/server_name`"
		if [ "x${HOSTNAME}" == "x${PBS_SERVER_NAME}" ] ; then
			PBS_START_SERVER=1;
		else
			PBS_START_SERVER=0;
		fi
	fi

	if [ ! -e /usr/spool/PBS/mom_priv/config ] ; then
		eerror "Missing config file /usr/spool/PBS/mom_priv/config"
		return 1
	elif [ "${PBS_START_SERVER}" -eq 1 ] ; then
		PBS_START_MOM="${PBS_SERVER_AND_MOM:=1}"
	else
		PBS_START_MOM="1"
	fi

	if [ "${PBS_START_SERVER}" -eq 1 ] ; then
		if [ ! -e /usr/spool/PBS/server_priv/nodes ] ; then
			eerror "The startup script has detected this node is a server"
			eerror "from the file /usr/spool/PBS/server_name,"
			eerror "but the config file /usr/spool/PBS/server_priv/nodes is missing"
			return 1
		fi
	fi

	if [ "${PBS_START_SERVER}" -eq 1 ] ; then
		if [ -z "${SCHEDFILE}" ]; then
			eerror "No scheduler defined and can't find pbs_sched"
			return 1
		elif [ ! -x ${SCHEDPATH} ] ; then
			eerror "Scheduler defined but can't be executed"
			return 1
		fi
	fi
}

start() {
	checkconfig || return 1

	if [ "${PBS_START_MOM}" -gt 0 ] ; then
		ebegin "Starting pbs_mom"
		start-stop-daemon --start --pidfile ${MOMPID} \
			--startas /usr/sbin/pbs_mom
	fi

	if [ "${PBS_START_SERVER}" -gt 0 ] ; then
		ebegin "Starting pbs_server"
		start-stop-daemon --start --quiet --pidfile ${SERVERPID} \
			--startas /usr/sbin/pbs_server

		ebegin "Starting ${SCHEDFILE}" 
		start-stop-daemon --start --quiet --pidfile ${SCHEDPID} \
			--startas ${SCHEDPATH}
	fi

	eend $?
}

stop() {
	checkconfig || return 1

	ret1=0
	ret2=0
	ret3=0
	if [ -e ${MOMPID} ] ; then
		ebegin "Stopping pbs_mom"
		start-stop-daemon --stop --pidfile ${MOMPID}
		ret1=$?
		rm -f ${MOMPID}
	fi

	if [ -e ${SERVERPID} ] ; then
		ebegin "Stopping pbs_server"
		qterm -t immediate
		ret2=$?
		rm -f ${SERVERPID}
	fi

	if [ -e ${SCHEDPID} ] ; then
		ebegin "Stopping ${SCHEDFILE}"
		start-stop-daemon --stop --pidfile ${SCHEDPID}
		ret3=$?
		rm -f ${SCHEDPID}
	fi

	let ret=$(( $ret1 + $ret2 + $ret3 )) 
	eend $ret
}
