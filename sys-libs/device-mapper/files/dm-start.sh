# /lib/rcscripts/addons/dm-start.sh:  Setup DM volumes at boot
# $Header: /var/cvsroot/gentoo-x86/sys-libs/device-mapper/files/dm-start.sh,v 1.3 2005/02/23 15:48:57 azarah Exp $

# char **get_new_dm_volumes(void)
#
#   Return dmsetup commands to setup volumes 
get_new_dm_volumes() {
	local volume params
	
	# Filter comments and blank lines
	grep -v -e '^[[:space:]]*\(#\|$\)' /etc/dmtab | \
	while read volume params; do
		# If it exists, skip it
		dmvolume_exists "${volume%:}" && continue
		# Assemble the command to run to create volume
		echo "echo ${params} | /sbin/dmsetup create ${volume%:}"
	done

	return 0
}

# int dmvolume_exists(volume)
#
#   Return true if volume exists in DM table
dmvolume_exists() {
	local x line volume=$1

	[[ -z ${volume} ]] && return 1
	
	while read line; do
		for x in ${line}; do
			[[ ${x} == "${volume}" ]] && return 0
			# We only want to check the volume name
			break
		done
	done <<<"$(/sbin/dmsetup ls 2>/dev/null)"

	return 1
}

# int is_empty_dm_volume(volume)
#
#   Return true if the volume exists in DM table, but is empty/non-valid
is_empty_dm_volume() {
	local table volume=$1
	
	table=$(/sbin/dmsetup table 2>/dev/null | grep -e "^${volume}:")
	
	# dmsetup seems to print an space after the colon for the moment
	[[ -n ${table} && -z ${table/${volume}:*} ]] && return 0

	return 1
}

local x volume

if [[ -x /sbin/dmsetup && -c /dev/mapper/control && -f /etc/dmtab ]]; then
	[[ -n $(get_new_dm_volumes) ]] && \
		einfo " Setting up device-mapper volumes:"

	while read x; do
		[[ -n ${x} ]] || continue

		volume="${x##* }"

		ebegin "  Creating volume: ${volume}"
		if ! eval ${x} &>/dev/null; then
			eend 1 "  Error creating volume: ${volume}"
			# dmsetup still adds an empty volume in some cases,
			#  so lets remove it
			is_empty_dm_volume "${volume}" && \
				/sbin/dmsetup remove "${volume}" &>/dev/null
		else
			eend 0
		fi
	done <<< "$(get_new_dm_volumes)"
fi


# vim:ts=4
