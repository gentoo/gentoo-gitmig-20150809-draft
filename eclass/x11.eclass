# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/x11.eclass,v 1.4 2004/11/03 10:15:05 spyderous Exp $
#
# Author: Seemant Kulleen <seemant@gentoo.org>
#
# The x11.eclass is designed to ease the checking functions that are
# performed in xorg-x11, xfree and x11-drm ebuilds.  In the new scheme, a
# variable called VIDEO_CARDS will be used to indicate which cards a user
# wishes to build support for.  Note, that this variable is only unlocked if
# the USE variable "expertxfree" is switched on, at least for xfree.

ECLASS=x11
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS vcards is_kernel strip_bins

vcards() {	
	has "$1" ${VIDEO_CARDS} && return 0
	return 1
}

filter-patch() {
	mv ${PATCH_DIR}/"*${1}*" ${PATCH_DIR}/excluded
}

patch_exclude() {
	# Exclude patches matching a pattern if they exist
	for PATCH_GROUP in ${@}
	do
		# Repress errors for non-matching patterns, they're ugly
		for PATCH in $(ls ${PATCHDIR}/${PATCH_GROUP}* 2> /dev/null)
		do
			if [ -a "${PATCH}" ]
			then
				ebegin "  `basename ${PATCH}`"
					mv -f ${PATCH} ${EXCLUDED}
				eend 0
			fi
		done
	done
}


# This is to ease kernel checks for patching and other things. (spyderous)
# Kernel checker is_kernel $1 $2 where $1 is KV_major and $2 is KV_minor.
# is_kernel "2" "4" should map to a 2.4 kernel, etc.

check_version_h() {
	if [ ! -f "${ROOT}/usr/src/linux/include/linux/version.h" ]
	then
		eerror "Please verify that your /usr/src/linux symlink is pointing"
		eerror "to your current kernel sources, and that you did run:"
		eerror
		eerror "  # make dep"
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

is_kernel() {
	get_KV_info

	if [ "${KV_major}" -eq "${1}" -a "${KV_minor}" -eq "${2}" ]
	then
		return 0
	else
		return 1
	fi
}

# For stripping binaries, but not drivers or modules.
# examples:
# /lib/modules for kernel modules:
# $1=\/lib\/modules
# /usr/X11R6/lib/modules for xfree modules:
# $1=\/usr\/X11R6\/lib\/modules
strip_bins() {
	einfo "Stripping binaries ..."
	# This bit I got from Redhat ... strip binaries and drivers ..
	# NOTE:  We do NOT want to strip the drivers, modules or DRI modules!
	for x in $(find ${D}/ -type f -perm +0111 -exec file {} \; | \
		grep -v ' shared object,' | \
		sed -n -e 's/^\(.*\):[  ]*ELF.*, not stripped/\1/p')
	do
	if [ -f ${x} ]
		then
			# Dont do the modules ...
			# need the 'eval echo \' to resolve 2-level variables
			if [ "`eval echo \${x/${1}}`" = "${x}" ]
			then
				echo "`echo ${x} | sed -e "s|${D}||"`"
				strip ${x} || :
			fi
		fi
	done
}

arch() {
	if archq ${1}; then
		echo "${1}"
		return 0
	fi
	return 1
}

archq() {
	local u="${1}"
	local neg=0
	if [ "${u:0:1}" == "!" ]; then
		u="${u:1}"
		neg=1
	fi
	local x
	for x in ${ARCH}; do
		if [ "${x}" == "${u}" ]; then
			if [ ${neg} -eq 1 ]; then
				return 1
			else
				return 0
			fi
		fi
	done
	if [ ${neg} -eq 1 ]; then
		return 0
	else
		return 1
	fi
}

# Function to ease the host.def editing and save lines in the ebuild
use_build() {
	if [ -z "$1" ]; then
		echo "!!! use_build() called without a parameter." >&2
		echo "!!! use_build <USEFLAG> [<flagname> [value]]" >&2
		return
	fi

	local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
		echo $UWORD
	fi

	if useq $1; then
		echo "#define ${UWORD} YES" >> ${HOSTCONF}
		return 0
	else
		echo "#define ${UWORD} NO" >> ${HOSTCONF}
		return 1
	fi
}

