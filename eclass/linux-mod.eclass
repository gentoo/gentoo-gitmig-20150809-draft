# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/linux-mod.eclass,v 1.10 2004/12/14 18:56:46 johnm Exp $

# Description: This eclass is used to interface with linux-info in such a way
#              to provide the functionality required and initial functions
#			   required to install external modules against a kernel source
#			   tree.
#
# Maintainer: John Mylchreest <johnm@gentoo.org>
# Copyright 2004 Gentoo Linux
#
# Please direct your bugs to the current eclass maintainer :)

# A Couple of env vars are available to effect usage of this eclass
# These are as follows:
# 
# Env Var		Option		Default			Description
# KERNEL_DIR	<string>	/usr/src/linux	The directory containing kernel
#											the target kernel sources.
# BUILD_PARAMS	<string>					The parameters to pass to make.
# BUILD_TARGETS	<string>	clean modules	The build targets to pass to make.
# MODULE_NAMES	<string>					This is the modules which are
#											to be built automatically using the
#											default pkg_compile/install. They
#											are explained properly below.


# MODULE_NAMES - Detailed Overview
# 
# The structure of each MODULE_NAMES entry is as follows:
# modulename(libmodulesdir:modulesourcedir)
# for example:
# MODULE_NAMES="module_pci(pci:${S}/pci) module_usb(usb:${S}/usb)"
# 
# what this would do is
#  cd ${S}/pci
#  make ${BUILD_PARAMS} ${BUILD_TARGETS}
#  insinto /lib/modules/${KV_FULL}/pci
#  doins module_pci.${KV_OBJ}
#
#  cd ${S}/usb
#  make ${BUILD_PARAMS} ${BUILD_TARGETS}
#  insinto /lib/modules/${KV_FULL}/usb
#  doins module_usb.${KV_OBJ}
#
# if the modulessourcedir isnt specified, it assumes ${S}
# if the libmodulesdir isnt specified, it assumes misc.
# if no seperator is defined ":" then it assumes the argument is modulesourcedir

inherit linux-info
ECLASS=linux-mod
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS pkg_setup pkg_postinst src_compile

DESCRIPTION="Based on the $ECLASS eclass"
SLOT=0
DEPEND="virtual/linux-sources
		sys-apps/sed"

# eclass utilities
# ----------------------------------

use_m() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	# if the kernel version is greater than 2.6.6 then we should use
	# M= instead of SUBDIRS=
	[ ${KV_MAJOR} -eq 2 -a ${KV_MINOR} -gt 5 -a ${KV_PATCH} -gt 5 ] && \
		return 0 || return 1
}

convert_to_m() {
	[ ! -f "${1}" ] && die "convert_to_m() requires a filename as an argument"
	if use_m
	then
		ebegin "Converting ${1/${WORKDIR}\//} to use M= instead of SUBDIRS="
		sed -i 's:SUBDIRS=:M=:g' ${1}
		eend $?
	fi
}

update_depmod() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	ebegin "Updating module dependencies for ${KV_FULL}"
	if [ -r ${KV_OUT_DIR}/System.map ]
	then
		depmod -ae -F ${KV_OUT_DIR}/System.map -b ${ROOT} -r ${KV_FULL}
	else
		ewarn
		ewarn "${KV_OUT_DIR}/System.map not found."
		ewarn "You must manually update the kernel module dependencies using depmod."
		ewarn
	fi
	eend $?
}

update_modules() {
	if [ -x /sbin/modules-update ] ;
	then
		ebegin "Updating modules.conf"
		/sbin/modules-update
		eend $?
	fi
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
	
	local modulename moduledir sourcedir moduletemp file i
	
	file=${ROOT}/etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}
	file=${file/\/\///}

	einfo "If you would like to load this module automatically upon boot"
	einfo "please type the following as root:"
	for i in ${MODULE_NAMES}
	do
		moduletemp="$(echo ${i} | sed -e "s:\(.*\)(\(.*\)):\1 \2:")"
		modulename="${moduletemp/ */}"
		moduletemp="${moduletemp/* /}"
		# if we specify two args, then we can set moduledir
		[ -z "${moduletemp/*:*/}" ] && moduledir="${moduletemp/:*/}"
		# if we didnt pass the brackets, then we shouldnt accept anything
		[ -n "${moduletemp/${modulename}/}" ] && sourcedir="${moduletemp/*:/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${sourcedir:-${S}}"
		
		einfo "    # echo \"${modulename}\" >> ${file}"
	done
	echo
}

# default ebuild functions
# --------------------------------

linux-mod_pkg_setup() {
	linux-info_pkg_setup;
	check_kernel_built;
	check_modules_supported;
	check_extra_config;
	set_kvobj;
}

linux-mod_src_compile() {
	local modulename moduledir sourcedir moduletemp xarch i
	xarch="${ARCH}"
	unset ARCH	

	for i in ${MODULE_NAMES}
	do
		moduletemp="$(echo ${i} | sed -e "s:\(.*\)(\(.*\)):\1 \2:")"
		modulename="${moduletemp/ */}"
		moduletemp="${moduletemp/* /}"
		# if we specify two args, then we can set moduledir
		[ -z "${moduletemp/*:*/}" ] && moduledir="${moduletemp/:*/}"
		# if we didnt pass the brackets, then we shouldnt accept anything
		[ -n "${moduletemp/${modulename}/}" ] && sourcedir="${moduletemp/*:/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${sourcedir:-${S}}"
		
		einfo "Preparing ${modulename} module"
		cd ${sourcedir}
		emake ${BUILD_PARAMS} ${BUILD_TARGETS:-clean module} || die Unable to make ${BUILD_PARAMS} ${BUILD_TARGETS:-clean module}.
	done
	ARCH="${xarch}"
}

linux-mod_src_install() {
	local modulename moduledir sourcedir moduletemp i

	for i in ${MODULE_NAMES}
	do
		moduletemp="$(echo ${i} | sed -e "s:\(.*\)(\(.*\)):\1 \2:")"
		modulename="${moduletemp/ */}"
		moduletemp="${moduletemp/* /}"
		# if we specify two args, then we can set moduledir
		[ -z "${moduletemp/*:*/}" ] && moduledir="${moduletemp/:*/}"
		# if we didnt pass the brackets, then we shouldnt accept anything
		[ -n "${moduletemp/${modulename}/}" ] && sourcedir="${moduletemp/*:/}"
		moduledir="${moduledir:-misc}"
		sourcedir="${sourcedir:-${S}}"

		einfo "Installing ${modulename} module"
		cd ${sourcedir}
		insinto /lib/modules/${KV_FULL}/${moduledir}
		doins ${modulename}.${KV_OBJ}
	done
}

linux-mod_pkg_postinst() {
	update_depmod;
	update_modules;
	display_postinst;
}
