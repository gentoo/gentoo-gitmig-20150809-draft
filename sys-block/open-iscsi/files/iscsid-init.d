#!/sbin/runscript
# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/files/iscsid-init.d,v 1.4 2006/03/07 08:26:46 robbat2 Exp $

PID_FILE=/var/run/iscsid.pid
CONFIG_FILE=/etc/iscsid.conf
DUMP_DIR=/var/db/iscsi
DUMP_NODE="${DUMP_DIR}/node.dump"
DUMP_DISCOVERY="${DUMP_DIR}/discovery.dump"
INITIATORNAME=/etc/initiatorname.iscsi
DAEMON=/usr/sbin/iscsid
NAME="iSCSI initiator service"

depend() {
	after modules
	use net
}

checkconfig() {
	if [ ! -f $CONFIG_FILE ]; then
		eerror "Config file $CONFIG_FILE does not exist!"
		return 1
	fi
	if [ ! -f $INITIATORNAME -o -z "$(egrep '^InitiatorName=' "${INITIATORNAME}")" ]; then
		eerror "$INITIATORNAME should contain a string with your initiatior name, eg:"
		eerror "InitiatorName=iqn.2005-09.tld.domainname.hostname:initiator-name"
		eerror "Initiator name file does not exist!"
		return 1
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
	checkconfig || return 1
	do_modules 'Loading iSCSI modules' 'scsi_transport_iscsi iscsi_tcp'
	ret=$?
	[ $ret -ne 0 ] && return 1
	ebegin "Starting ${NAME}"
	start-stop-daemon --start --exec $DAEMON --quiet
	ret=$?
	eend $ret
	return $ret
}
	
stop() {
	ebegin "Stopping ${NAME}"
	start-stop-daemon --signal HUP --stop --quiet --exec $DAEMON #--pidfile $PID_FILE
	eend $?

	# ugly, but pid file is not removed by iscsid
	rm -f $PID_FILE
	
	do_modules 'Removing iSCSI modules' 'iscsi_tcp scsi_transport_iscsi' '-r'
	ret=$?
	return $ret
}

opts="${opts} dump"

dump() {
	einfo "Starting dump of iscsid database (nodes)"
	NODELIST="$(iscsiadm -m node |  awk -F '[\\[\\]]' '{print $2}')"
	[ -f ${DUMP_NODE} ] && mv -f ${DUMP_NODE} ${DUMP_NODE}.old
	for i in $NODELIST ; do
		echo "# $(iscsiadm -m node | egrep "^\[$i\]")" >>${DUMP_NODE}
		iscsiadm -m node --record=$i >>${DUMP_NODE}
		echo >>${DUMP_NODE}
	done
	einfo "Starting dump of iscsid database (discovery)"
	DISCOVERYLIST="$(iscsiadm -m discovery |  awk -F '[\\[\\]]' '{print $2}')"
	[ -f ${DUMP_DISCOVERY} ] && mv -f ${DUMP_DISCOVERY} ${DUMP_DISCOVERY}.old
	for i in $DISCOVERYLIST ; do
		echo "# $(iscsiadm -m discovery | egrep "^\[$i\]")" >>${DUMP_DISCOVERY}
		iscsiadm -m discovery --record=$i >>${DUMP_DISCOVERY}
		echo >>${DUMP_DISCOVERY}
	done

	einfo "Config dumped to ${DUMP_DIR}/"
}
