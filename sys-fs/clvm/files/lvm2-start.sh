# /lib/rcscripts/addons/lvm2-start.sh
# $Header: /var/cvsroot/gentoo-x86/sys-fs/clvm/files/lvm2-start.sh,v 1.4 2008/11/21 23:31:44 xmerlin Exp $

# LVM support for /usr, /home, /opt ....
# This should be done *before* checking local
# volumes, or they never get checked.
			        
# NOTE: Add needed modules for LVM or RAID, etc
#       to /etc/modules.autoload if needed
if [[ -z ${CDBOOT} ]] && [[ -x /sbin/vgscan ]] ; then
	if [[ -e /proc/modules ]] && \
	   ! grep -qs 'device-mapper' /proc/{devices,misc}
	then
		modprobe dm-mod &>/dev/null
	fi

	if [[ -d /proc/lvm ]] || grep -qs 'device-mapper' /proc/{devices,misc} ; then
		ebegin "Setting up the Logical Volume Manager"
		#still echo stderr for debugging
		/sbin/vgscan --mknodes --ignorelockingfailure >/dev/null
		if [[ $? == 0 ]] && [[ -x /sbin/vgchange ]] && \
		   [[ -f /etc/lvmtab || -d /etc/lvm ]]
		then
			noclustervgs=`/sbin/vgdisplay 2> /dev/null | \
				awk 'BEGIN {RS="VG Name"} {if (!/Clustered/) { if ($1 != "---") print $1; } }'`
			for vg in $noclustervgs; do
				/sbin/vgchange --ignorelockingfailure -a y ${vg} >/dev/null
			done
		fi
		eend $? "Failed to setup the LVM"
	fi
fi

# vim:ts=4
