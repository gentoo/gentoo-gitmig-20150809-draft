# /lib/rcscripts/addons/lvm2-stop.sh
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/files/lvm2-stop.sh,v 1.1 2005/03/25 02:32:08 xmerlin Exp $

# Stop LVM2

if [ -x /sbin/vgchange ] && \
   [ -x /sbin/lvdisplay ] && \
   [ -x /sbin/vgdisplay ] && \
   [ -x /sbin/lvchange ] && \
   [ -f /etc/lvmtab -o -d /etc/lvm ] && \
   [ -d /proc/lvm  -o "`grep device-mapper /proc/misc 2>/dev/null`" ]
then
	einfo "Shutting down the Logical Volume Manager"
	# If these commands fail it is not currently an issue
	# as the system is going down anyway based on the current LVM 
	# functionality as described in this forum thread
	#https://www.redhat.com/archives/linux-lvm/2001-May/msg00523.html

	LOGICAL_VOLUMES=`lvdisplay |grep "LV Name"|awk '{print $3}'|sort|xargs echo`
	VOLUME_GROUPS=`vgdisplay |grep "VG Name"|awk '{print $3}'|sort|xargs echo`
	for x in ${LOGICAL_VOLUMES}
	do
		LV_IS_ACTIVE=`lvdisplay ${x}|grep "# open"|awk '{print $3}'`
		if [ "${LV_IS_ACTIVE}" = 0 ]
		then
			ebegin "  Shutting Down logical volume: ${x} "
			lvchange -an --ignorelockingfailure -P ${x} >/dev/null
			eend $?
		fi
	done

	for x in ${VOLUME_GROUPS}
	do
		VG_HAS_ACTIVE_LV=`vgdisplay ${x}|grep "Open LV"|awk '{print $3}'|xargs echo`
		if [ "${VG_HAS_ACTIVE_LV}" = 0 ]
		then
			ebegin "  Shutting Down volume group: ${x} "
			vgchange -an --ignorelockingfailure -P ${x} >/dev/null
			eend
		fi
	done

	for x in ${LOGICAL_VOLUMES}
	do
		LV_IS_ACTIVE=`lvdisplay ${x}|grep "# open"|awk '{print $3}'`
		if [ "${LV_IS_ACTIVE}" = 1 ]
		then
			
			ROOT_DEVICE=`mount|grep " / "|awk '{print $1}'`
			if [ ! ${ROOT_DEVICE} = ${x} ]
			then
				ewarn "  Unable to shutdown: ${x} "
			fi
		fi
	done
	einfo "Finished Shutting down the Logical Volume Manager"
fi

# vim:ts=4
