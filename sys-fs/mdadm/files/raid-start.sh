# /lib/rcscripts/addons/raid-start.sh:  Setup raid volumes at boot
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/files/raid-start.sh,v 1.1 2005/03/02 04:32:07 vapier Exp $

[[ -f /proc/mdstat ]] || exit 0

# We could make this dynamic, but eh
#[[ -z ${MAJOR} ]] && export MAJOR=$(awk '$2 == "md" { print $1 }' /proc/devices)
MAJOR=9

# Try to make sure the devices exist before we use them
create_devs() {
	local d
	for d in $@ ; do
		d=${d/\/dev\/}
		[[ -e /dev/${d} ]] && continue
		mknod /dev/${d} b ${MAJOR} ${d##*md} >& /dev/null
	done
}

# Start software raid with raidtools (old school)
if [[ -x /sbin/raidstart && -f /etc/raidtab ]] ; then
	create_devs $(awk '/^[[:space:]]*raiddev/ { print $2 }' /etc/raidtab)
	ebegin "Starting up RAID devices (raidtools)"
	output=$(raidstart -a 2>&1)
	ret=$?
	[[ ${ret} -ne 0 ]] && echo "${output}"
	eend ${ret}
fi

# Start software raid with mdadm (new school)
if [[ -x /sbin/mdadm && -f /etc/mdadm.conf ]] ; then
	create_devs $(awk '/^[[:space:]]*ARRAY/ { print $2 }' /etc/mdadm.conf)
	ebegin "Starting up RAID devices (mdadm)"
	output=$(mdadm -As 2>&1)
	ret=$?
	[[ ${ret} -ne 0 ]] && echo "${output}"
	eend ${ret}
fi

# vim:ts=4
