# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/linux-mod.eclass,v 1.2 2004/11/25 19:47:18 johnm Exp $

# This eclass provides functions for compiling external kernel modules
# from source.

inherit linux-info
ECLASS=linux-mod
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS pkg_setup pkg_postinst src_compile

DESCRIPTION="Based on the $ECLASS eclass"
SLOT=0
DEPEND="virtual/linux-sources
		sys-apps/sed"


# This eclass is designed to help ease the installation of external kernel
# modules into the kernel tree.

# eclass utilities
# ----------------------------------

use_m() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	# if the kernel version is greater than 2.6.6 then we should use
	# M= instead of SUBDIR=
	[ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -gt 5 -a ${KV_PATCH} -gt 5 ] && \
		return 0 || return 1
}

convert_to_m() {
	[ ! -f "${1}" ] && die "convert_to_m() requires a filename as an argument"
	if use_m
	then
		ebegin "Converting ${1/${WORKDIR}\//} to use M= instead of SUBDIR="
		sed -i 's:SUBDIRS=:M=:g' ${1}
		eend $?
	fi
}

update_depmod() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	ebegin "Updating module dependencies for ${KV_FULL}"
	if [ -r ${KV_DIR}/System.map ]
	then
		depmod -ae -F ${KV_DIR}/System.map -b ${ROOT} -r ${KV_FULL}
	else
		ewarn
		ewarn "${KV_DIR}/System.map not found."
		ewarn "You must manually update the kernel module dependencies using depmod."
		ewarn
	fi
	eend $?
}

set_kvobj() {
	if kernel_is 2 6
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi
	einfo "Using KV_OBJ=${KV_OBJ}"
}

display_postinst() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	local modulename moduledir sourcedir module_temp file i
	
	file=${ROOT}/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}
	file=${file/\/\///}

	einfo "If you would like to load this module automatically upon boot"
	einfo "please type the following as root:"
	for i in ${MODULE_NAMES}
	do
		module_temp="$(echo ${i} | sed -e "s:.*(\(.*\)):\1:")"
		modulename="${i/(*/}"
		moduledir="${module_temp/:*/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${module_temp/*:/}"
		sourcedir="${sourcedir:-${S}}"
		
		einfo "    # echo \"${modulename}\" >> ${file}"
	done
	echo
}

# default ebuild functions
# --------------------------------

linux-mod_pkg_setup() {
	get_version;
	check_kernel_built
	check_modules_supported;
	set_kvobj;
}

linux-mod_src_compile() {
	local modulename moduledir sourcedir module_temp xarch i
	xarch="${ARCH}"
	unset ARCH	

	for i in ${MODULE_NAMES}
	do
		module_temp="$(echo ${i} | sed -e "s:.*(\(.*\)):\1:")"
		modulename="${i/(*/}"
		moduledir="${module_temp/:*/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${module_temp/*:/}"
		sourcedir="${sourcedir:-${S}}"
	
		einfo "Preparing ${modulename} module"
		cd ${sourcedir}
		make clean
		make ${BUILD_PARAMS} module
	done
	ARCH="${xarch}"
}

linux-mod_src_install() {
	local modulename moduledir sourcedir module_temp i

	for i in "${MODULE_NAMES}"
	do
		module_temp="$(echo ${i} | sed -e "s:.*(\(.*\)):\1:")"
		modulename="${i/(*/}"
		moduledir="${module_temp/:*/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${module_temp/*:/}"
		sourcedir="${sourcedir:-${S}}"

		einfo "Installing ${modulename} module"
		cd ${sourcedir}
		insinto /lib/modules/${KV_FULL}/${moduledir}
		doins ${modulename}.${KV_OBJ}
	done
}

linux-mod_pkg_postinst() {
	update_depmod;
	display_postinst;
}
