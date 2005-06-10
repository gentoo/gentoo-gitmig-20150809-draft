# /lib/rcscripts/addons/raid-stop.sh:  Stop raid volumes at shutdown
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/raidtools/files/raid-stop.sh,v 1.1 2005/06/10 01:34:57 vapier Exp $

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
if [[ -x /sbin/mdadm && -f /etc/mdadm.conf ]] ; then
	ebegin "Shutting down RAID devices (mdadm)"
	output=$(mdadm -Ss 2>&1)
	ret=$?
	[[ ${ret} -ne 0 ]] && echo "${output}"
	eend ${ret}
fi

# vim:ts=4
