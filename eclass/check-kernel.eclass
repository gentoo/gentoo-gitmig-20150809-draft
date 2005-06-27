# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/check-kernel.eclass,v 1.5 2005/06/27 20:18:40 agriffis Exp $

# Author: Martin Schlemmer <azarah@gentoo.org>
# Eclass'd by: Seemant Kulleen <seemant@gentoo.org>
#
# The check-kernel eclass is designed to detect the kernel sources and
# report info on the versions

ECLASS=check-kernel
INHERITED="${INHERITED} ${ECLASS}"

DEPEND="sys-apps/gawk"

check_version_h() {
	if [ ! -f "${ROOT}/usr/src/linux/include/linux/version.h" ]
	then
		eerror "Please verify that your /usr/src/linux symlink is pointing"
		eerror "to your current kernel sources, and that you did run:"
		eerror
		eerror "  # make dep"
		eerror
		eerror "(${ROOT}/usr/src/linux/include/linux/version.h does not exist)"
		die "/usr/src/linux symlink not setup!"
	fi
}

get_KV_info() {
	check_version_h

	# Get the kernel version of sources in /usr/src/linux ...
	export KV_full="$(awk '/UTS_RELEASE/ { gsub("\"", "", $3); print $3 }' \
		"${ROOT}/usr/src/linux/include/linux/version.h")"
	export KV_major="$(echo "${KV_full}" | cut -d. -f1)"
	export KV_minor="$(echo "${KV_full}" | cut -d. -f2)"
	export KV_micro="$(echo "${KV_full}" | cut -d. -f3 | sed -e 's:[^0-9].*::')"
}

is_2_4_kernel() {
	get_KV_info
	
	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 4 ]
	then
		return 0
	else
		return 1
	fi
}

is_2_5_kernel() {
	get_KV_info
	
	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
	then
		return 0
	else
		return 1
	fi
}

is_2_6_kernel() {
	get_KV_info

	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 6 ]
	then
		return 0
	else
		return 1
	fi
}

kernel_supports_modules() {
	grep '^CONFIG_MODULES=y$' ${ROOT}/usr/src/linux/include/linux/autoconf.h >& /dev/null
}
