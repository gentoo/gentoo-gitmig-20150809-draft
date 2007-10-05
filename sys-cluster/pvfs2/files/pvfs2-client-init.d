#!/sbin/runscript
# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pvfs2/files/pvfs2-client-init.d,v 1.1 2007/10/05 14:03:13 mabi Exp $


depend() {
	need net
	need localmount
	before pbs_mom
	after pvfs2-server
}

checkconfig() {
	if [ ! -x "${PVFS2_CLIENT}" ] || [ ! -x "${PVFS2_CLIENT_CORE}" ]; then
		eend 1 "pvfs-2 was not correctly installed."
		return 1
	fi

	if [ ! -d "${PVFS2_MOUNTPOINT}" ]; then
		ewarn "Creating ${PVFS2_MOUNTPOINT}"
		mkdir -p ${PVFS2_MOUNTPOINT} || return 1
	fi

	local piddir=$(dirname ${PVFS2_CLIENT_PIDFILE})
	if [ ! -d "${piddir}" ]; then
		ewarn "Creating ${piddir}"
		mkdir -p ${piddir} || return 1
	fi

	return 0
}

start() {
	ebegin "Starting pvfs2-client"
	local rc=0

	$(lsmod | egrep "^pvfs2 " &> /dev/null) || modprobe pvfs2 
	if [[ $? -ne 0 ]]; then
		eend 1 "Failed to load the pvfs2 module"
		return 1
	fi

    # -f so start-stop-daemon can snag the pid. 
	start-stop-daemon --start -q -b -m -p ${PVFS2_CLIENT_PIDFILE} \
	--exec ${PVFS2_CLIENT} -- -f -p ${PVFS2_CLIENT_CORE} ${PVFS2_CLIENT_ARGS}
	rc=$?

	if [[ $rc -ne 0 ]]; then
		eend ${rc} "Failed to run pvfs2-client"
		return ${rc} 
	fi

	mount -t pvfs2 tcp://${PVFS2_SERVER_HOST}:3334/pvfs2-fs "${PVFS2_MOUNTPOINT}"
	rc=$?
	if [[ $rc -ne 0 ]]; then
		eend 1 "Failed to mount the pvfs2 filesystem on ${PVFS2_MOUNTPOINT}"
		return 1
	fi

	eend ${rc}
}

stop() {
	ebegin "Stopping pvfs2-client"
	if [ -n "$(mount | awk '{print $3}' | grep ${PVFS2_MOUNTPOINT})" ]; then
		umount -f ${PVFS2_MOUNTPOINT}
	fi

	start-stop-daemon --stop -p ${PVFS2_CLIENT_PIDFILE} 

	modprobe -r pvfs2 

	eend $?
}

