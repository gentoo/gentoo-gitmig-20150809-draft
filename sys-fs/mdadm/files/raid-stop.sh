# /lib/rcscripts/addons/raid-stop.sh:  Stop raid volumes at shutdown
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/files/raid-stop.sh,v 1.2 2006/11/10 00:27:07 vapier Exp $

[[ -f /proc/mdstat ]] || exit 0

# Stop software raid with raidtools (old school)
if [[ -x /sbin/raidstop && -f /etc/raidtab ]] ; then
	ebegin "Shutting down RAID devices (raidtools)"
	output=$(raidstop -a 2>&1)
	ret=$?
	[[ ${ret} -ne 0 ]] && echo "${output}"
	eend ${ret}
fi

# Stop software raid with mdadm (new school)
mdadm_conf="/etc/mdadm/mdadm.conf"
[[ -e /etc/mdadm.conf ]] && mdadm_conf="/etc/mdadm.conf"
if [[ -x /sbin/mdadm && -f ${mdadm_conf} ]] ; then
	ebegin "Shutting down RAID devices (mdadm)"
	output=$(mdadm -Ss 2>&1)
	ret=$?
	[[ ${ret} -ne 0 ]] && echo "${output}"
	eend ${ret}
fi

# vim:ts=4
