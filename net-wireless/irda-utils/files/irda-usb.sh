#!/bin/bash

# Find out where sysfs is mounted. Exit if not available
SYSFS=$(/bin/sed -n "s:^[^ ]* \([^ ]\+\) sysfs .*:\1:p" /proc/mounts)
if [[ -z "${SYSFS}" ]]; then
	echo "sysfs is required"
	exit 1
fi

case "${ACTION}" in
	add)
		MODALIAS="${SYSFS}${DEVPATH}/device/modalias"
		if [[ -f "${MODALIAS}" ]]; then
			case $(<"${MODALIAS}") in
				usb:*)
					# attach USB-IrDA interface
					/usr/sbin/irattach ${INTERFACE} -s
					;;
			esac
		fi
		;;
	remove)
		# unconditionally kill irattach instance
		/usr/bin/pkill -f "^/usr/sbin/irattach ${INTERFACE} ?"
		;;
esac
