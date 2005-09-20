#!/sbin/runscript
# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-block/open-iscsi/files/iscsid-init.d,v 1.1 2005/09/20 04:33:34 robbat2 Exp $

PID_FILE=/var/run/iscsid.pid
CONFIG_FILE=/etc/iscsid.conf
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
	echo -n "Starting iSCSI initiator service: "
	modprobe scsi_transport_iscsi
	modprobe iscsi_tcp
	start-stop-daemon --start --exec $DAEMON --quiet
	RETVAL=$?
	if [ $RETVAL == "0" ]; then
	    echo "succeeded."
	else
	    echo "failed."
	fi	    

	echo -n "Removing iSCSI modules: "
	modprobe -r iscsi_tcp
	modprobe -r scsi_transport_iscsi
	RETVAL=$?
	if [ $RETVAL == "0" ]; then
	    echo "succeeded."
	else
	    echo "failed."
	    return 1
	fi
}
	
stop() {
	echo -n "Stopping iSCSI initiator service: "
	start-stop-daemon --stop --quiet --exec $DAEMON --pidfile $PID_FILE
	RETVAL=$?
	if [ $RETVAL == "0" ]; then
	    echo "succeeded."
	else
	    echo "failed."
	fi
	# ugly, but pid file is not removed by iscsid
	rm -f $PID_FILE
}

opts="${opts} dump"

dump() {
	DUMP=`tempfile -p iscsid`
	RETVAL=$?
	if [ $RETVAL != "0" ]; then
	    echo "Failed to create dump file $DUMP"
	    return 1
	fi
	/usr/sbin/iscsiadm -m node --record 0a45f8 >$DUMP
	RETVAL=$?
	if [ $RETVAL != "0" ]; then
	    echo "Error dumping config from daemon"
	    rm $DUMP
	    return 1
	fi
	mv -u $DUMP $CONFIG_FILE
	echo "Config dumped to $CONFIG_FILE"
}
