# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

udev_version() {
	# Version number copied in by ebuild
	local version=@@UDEV_VERSION@@
	version=${version##0}

	echo "${version}"
}

# store persistent-rules that got created while booting
# when / was still read-only
store_persistent_rules() {
	local type base tmp_rules real_rules

	for type in cd net; do
		base=70-persistent-${type}.rules
		tmp_rules=/dev/.udev/tmp-rules--${base}
		real_rules=/etc/udev/rules.d/${base}

		if [[ -f ${tmp_rules} ]]; then
			einfo "Saving udev persistent ${type} rules to /etc/udev/rules.d"
			cat ${tmp_rules} >> ${real_rules}
			rm ${tmp_rules}
		fi
	done
}

main() {
	store_persistent_rules

	if [[ -e /dev/.devfsd || ! -e /dev/.udev || ! -z ${CDBOOT} || \
	   ${RC_DEVICE_TARBALL} != "yes" ]] || \
	   ! touch /lib/udev/state/devices.tar.bz2 2>/dev/null
	then
		return 0
	fi
		
	ebegin "Saving device nodes"
	# Handle our temp files
	save_tmp_base=/tmp/udev.savedevices."$$"
	devices_udev="${save_tmp_base}"/devices.udev
	devices_real="${save_tmp_base}"/devices.real
	devices_totar="${save_tmp_base}"/devices.totar
	device_tarball="${save_tmp_base}"/devices
	
	rm -rf "${save_tmp_base}"
	mkdir "${save_tmp_base}"
	touch "${devices_udev}" "${devices_real}" \
		"${devices_totar}" "${device_tarball}"
	
	if [[ ! ( -f ${devices_udev} && -f ${devices_real} && \
		  -f ${devices_totar} && -f ${device_tarball} ) ]] ; then
		eend 1 "Could not create temporary files!"
	else
		cd /dev
		# Find all devices
		find . -xdev -type b -or -type c -or -type l | cut -d/ -f2- > \
			"${devices_real}"
		# Figure out what udev created
		eval $(grep '^[[:space:]]*udev_db=' /etc/udev/udev.conf)
		if [[ -d ${udev_db} ]]; then
			# New udev_db is clear text ...
			udevinfo=$(cat "${udev_db}"/*)
		else
			# if no udev_db
			if [[ $(udev_version) -ge "104" ]]; then
				udevinfo=$(udevinfo --export-db)
			else
				# Old one is not ...
				udevinfo=$(udevinfo -d)
			fi
		fi
		# This basically strips 'S:' and 'N:' from the db output, and then
		# print all the nodes/symlinks udev created ...
		echo "${udevinfo}" | gawk '
			/^(N|S):.+/ {
				sub(/^(N|S):/, "")
				split($0, nodes)
				for (x in nodes)
					print nodes[x]
			}' > "${devices_udev}"
		# These ones we also do not want in there
		for x in MAKEDEV core fd initctl pts shm stderr stdin stdout; do
			echo "${x}" >> "${devices_udev}"
		done
		if [[ -d /lib/udev/devices ]]; then
			cd /lib/udev/devices
			find . -xdev -type b -or -type c -or -type l | cut -d/ -f2- >> "${devices_udev}"
		fi
		cd /dev
		fgrep -x -v -f "${devices_udev}" < "${devices_real}" | \
		  grep -v ^\\.udev > "${devices_totar}"

		# Now only tarball those not created by udev if we have any
		if [[ -s ${devices_totar} ]]; then
			# we dont want to descend into mounted filesystems (e.g. devpts)
			# looking up username may involve NIS/network, and net may be down
			tar --one-file-system --numeric-owner -jcpf "${device_tarball}" -T "${devices_totar}"
			mv -f "${device_tarball}" /lib/udev/state/devices.tar.bz2
		else
			rm -f /lib/udev/state/devices.tar.bz2
		fi
		eend 0
	fi

	rm -rf "${save_tmp_base}"
}

main


# vim:ts=4
