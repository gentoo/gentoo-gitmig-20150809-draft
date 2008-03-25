#!/sbin/runscript
# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/files/iscsid-2.0.868_rc1.init.d,v 1.1 2008/03/25 02:33:04 kingtaco Exp $

depend() {
	after modules
	use net
}

checkconfig() {
	if [ ! -f $CONFIG_FILE ]; then
		eerror "Config file $CONFIG_FILE does not exist!"
		return 1
	fi
	if ! grep "^InitiatorName=iqn." ${INITIATORNAME_FILE} &>/dev/null; then
		ewarn "${INITIATORNAME_FILE} should contain a string with your initiatior name."
		IQN=iqn.$(date +%Y-%m).$(hostname -f | awk 'BEGIN { FS=".";}{x=NF; while (x>0) {printf $x ;x--; if (x>0) printf ".";} print ""}'):openiscsi
		IQN=${IQN}-$(echo ${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM} | md5sum | sed -e "s/\(.*\) -/\1/g" -e 's/ //g')
		ebegin "Creating InitiatorName ${IQN} in ${INITIATORNAME_FILE}"
		echo "InitiatorName=${IQN}" >> ${INITIATORNAME_FILE}
		eend $?
	fi
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
	checkconfig
	do_modules 'Loading iSCSI modules' 'scsi_transport_iscsi iscsi_tcp'
	ret=$?
	[ $ret -ne 0 ] && return 1
	ebegin "Starting ${SVCNAME}"
	start-stop-daemon --start --quiet --exec /usr/sbin/iscsid -- ${OPTS}
	ret=$?
	eend $ret
	return $ret
}
	
stop() {
	ebegin "Stopping ${SVCNAME}"
	start-stop-daemon --signal HUP --stop --quiet --exec /usr/sbin/iscsid #--pidfile $PID_FILE
	eend $?

	# ugly, but pid file is not removed by iscsid
	rm -f $PID_FILE
	
	do_modules 'Removing iSCSI modules' 'iscsi_tcp scsi_transport_iscsi' '-r'
	ret=$?
	return $ret
}

