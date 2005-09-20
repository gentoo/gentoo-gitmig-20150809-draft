#!/sbin/runscript
# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/files/iscsid-init.d,v 1.2 2005/09/20 08:00:38 robbat2 Exp $

PID_FILE=/var/run/iscsid.pid
CONFIG_FILE=/etc/iscsid.conf
DUMP_DIR=/var/db/iscsi
DUMP_NODE="${DUMP_DIR}/node.dump"
DUMP_DISCOVERY="${DUMP_DIR}/discovery.dump"
INITIATORNAME=/etc/initiatorname.iscsi
DAEMON=/usr/sbin/iscsid

depend() {
	after modules
}

checkconfig() {
	[ ! -f $CONFIG_FILE ] && die "Config file $CONFIG_FILE does not exist!"
	if [ ! -f $INITIATORNAME ]; then
		eerror "$INITIATORNAME should contain a string with your initiatior name, eg:"
		errror "InitiatorName=iqn.2005-09.tld.domainname.hostname:initiator-name"
		die "Initiator name file does not exist!"
	fi
}

start() {
	checkconfig
	ebegin "Starting iSCSI initiator service"
	modprobe scsi_transport_iscsi
	modprobe iscsi_tcp
	start-stop-daemon --start --exec $DAEMON --quiet
	ret=$?
	eend $ret
	[ $ret -gt 0 ] && return $ret
}
	
stop() {
	ebegin "Stopping iSCSI initiator service"
	start-stop-daemon --stop --quiet --exec $DAEMON --pidfile $PID_FILE
	eend $?

	# ugly, but pid file is not removed by iscsid
	rm -f $PID_FILE
	
	ebegin "Removing iSCSI modules"
	modprobe -r iscsi_tcp
	modprobe -r scsi_transport_iscsi
	ret=$?
	eend $ret
	[ $ret -gt 0 ] && return $ret
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
