# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/eclass/mount-boot.eclass,v 1.4 2002/10/13 02:34:18 woodchip Exp $

ECLASS=mount-boot
INHERITED="$INHERITED $ECLASS"

mount-boot_pkg_setup(){

[ "${ROOT}" != "/" ] && return 0

	local fstabstate="$(cat /etc/fstab | awk '!/^#|^[[:blank:]]+#|^\/dev\/BOOT/ {print $2}' | egrep "/boot" )"
	local procstate="$(cat /proc/mounts | awk '{print $2}' | egrep "/boot" )"
	local proc_ro="$(cat /proc/mounts | awk '{ print $2, $4 }' | sed -n '/\/boot/{ /[ ,]\?ro[ ,]\?/p }' )"

	if [ -n "${fstabstate}" ] && [ -n "${procstate}" ]; then
		if [ -n "${proc_ro}" ]; then
			echo
			einfo "Your boot partition, detected as being mounted as /boot, is read-only"
			einfo "Remounting it in read-write mode"
			sleep 1; echo -ne "\a"; sleep 1; echo -e "\a"
			mount -o remount,rw /boot &>/dev/null
			if [ "$?" -ne 0 ]; then
				eerror; eerror "Unable to remount in rw mode. Please do it manually" ; eerror
				sleep 1; echo -ne "\a"; sleep 1; echo -e "\a"
				die "Can't remount in rw mode. Please do it manually"
			fi
		else
			echo
			einfo "Your boot partition was detected as being mounted as /boot."
			einfo "Files will be installed there for ${PN} to function correctly."
			sleep 1; echo -ne "\a"; sleep 1; echo -e "\a"
		fi
	elif [ -n "${fstabstate}" ] && [ -z "${procstate}" ]; then
		mount /boot -o rw &>/dev/null
		if [ "$?" -eq 0 ]; then
			echo
			einfo "Your boot partition was not mounted as /boot, but portage"
			einfo "was able to mount it without additional intervention."
			einfo "Files will be installed there for ${PN} to function correctly."
			sleep 1; echo -ne "\a"; sleep 1; echo -e "\a"
		else
			echo
			eerror "Cannot mount automatically your boot partition."
			eerror "Your boot partition has to be mounted on /boot before the installation"
			eerror "can continue. ${PN} needs to install important files there."
			sleep 1; echo -ne "\a"; sleep 1; echo -e "\a"
			die "Please mount your /boot partition."
		fi
	else
		echo
		einfo "Assuming you do not have a separate /boot partition."
		sleep 1; echo -ne "\a"; sleep 1; echo -e "\a";
	fi
}

EXPORT_FUNCTIONS pkg_setup
