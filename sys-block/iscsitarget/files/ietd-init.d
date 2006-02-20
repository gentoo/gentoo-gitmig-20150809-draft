#!/sbin/runscript
# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/iscsitarget/files/ietd-init.d,v 1.1 2006/02/20 08:33:40 robbat2 Exp $

MEM_SIZE=1048576
DAEMON=/usr/sbin/ietd
CONFIG_FILE=/etc/ietd.conf
PID_FILE=/var/run/iscsi_trgt.pid
NAME="iSCSI Enterprise Target"

ARGS=""
[ -n "$USER" ] && ARGS="${ARGS} --uid=${USER}"
[ -n "$GROUP" ] && ARGS="${ARGS} --gid=${GROUP}"
[ -n "$ISNS" ] && ARGS="${ARGS} --isns=${ISNS}"
[ -n "$PORT" ] && ARGS="${ARGS} --port=${PORT}"
[ -n "$ADDRESS" ] && ARGS="${ARGS} --address=${ADDRESS}"
[ -n "$DEBUGLEVEL" ] && ARGS="${ARGS} --debug=${DEBUGLEVEL}"

depend() {
	use net
	after modules
}
checkconfig() {
	if [ ! -f $CONFIG_FILE ]; then
		eerror "Config file $CONFIG_FILE does not exist!"
		return 1
	fi
	if [ -z "$DISABLE_MEMORY_WARNINGS" ]; then
		check_memsize
	fi
}

check_memsize() {
	for sysctl_key in net.core.{w,r}mem_{max,default}; do
		v="$(sysctl -n ${sysctl_key})"
		if [ "${v}" -lt "${MEM_SIZE}" ]; then
			ewarn "$sysctl_key is lower than recommended ${MEM_SIZE}"
		fi
	done
	for sysctl_key in net.ipv4.tcp_{,r,w}mem ; do
		v="$(sysctl -n ${sysctl_key} | xargs)"
		v1="${v/ *}" v2="${v#* }" v3="${v2/* }" v2="${v2/ *}"
		min="${v1}" default="${v2}" max="${v3}"
		for k in min default max ; do
			if [ "${!k}" -lt "${MEM_SIZE}" ]; then
				ewarn "$sysctl_key:$k is lower than recommended ${MEM_SIZE}"
			fi
		done
	done
}

do_modules() {
	msg="$1"
	shift
	modules="$1"
	shift
	opts="$@"
	for m in ${modules}; do
		ebegin "${msg} - ${m}"
		modprobe ${opts} $m
		ret=$?
		eend $ret
		[ $ret -ne 0 ] && return $ret
	done
	return 0
}

start() {
	checkconfig || return 1
	do_modules 'Loading iSCSI-Target modules' 'iscsi_trgt'
	ebegin "Starting ${NAME}"
	start-stop-daemon --start --exec $DAEMON --quiet -- ${ARGS}
	eend $?
}

stop() {
	ebegin "Removing ${NAME} devices"
    # ugly, but ietadm does not allways provides correct exit values
	RETURN="$(ietadm --op delete 2>&1)"
	RETVAL=$?
	if [ $RETVAL == "0" ] && [[ $RETURN != "something wrong" ]]; then
		eend 0
	else
		eend 1
		eerror "ietadm failed - $RETURN"
		return 1
	fi

	ebegin "Stopping ${NAME}"
	start-stop-daemon --stop --quiet --exec $DAEMON --pidfile $PID_FILE
	ret=$?
	eend $ret
	[ $ret -ne 0 ] && return 1

	# ugly, but pid file is not removed by ietd
	rm -f $PID_FILE
	do_modules 'Removing iSCSI-Target modules' 'iscsi_trgt' '-r'
	return $?
}

# vim: tw=72:
