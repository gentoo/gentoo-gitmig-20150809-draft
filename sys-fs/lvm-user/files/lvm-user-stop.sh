# /lib/rcscripts/addons/lvm-user-stop.sh
# $Header: /var/cvsroot/gentoo-x86/sys-fs/lvm-user/files/lvm-user-stop.sh,v 1.1 2005/02/23 03:47:44 rocket Exp $

# Stop LVM

if [ -x /sbin/vgchange ] && [ -f /etc/lvmtab -o -d /etc/lvm ] && \
	[ -d /proc/lvm  -o "`grep device-mapper /proc/misc 2>/dev/null`" ]
then
	ebegin "Shutting down the Logical Volume Manager"
	/sbin/vgchange -a n >/dev/null
	eend $? "Failed to shut LVM down"
fi

# vim:ts=4
