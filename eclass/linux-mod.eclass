# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/linux-mod.eclass,v 1.16 2005/01/06 17:58:59 johnm Exp $

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
#											It will only make BUILD_TARGETS once
#											in any directory.
# NO_MODULESD	<string>					Set this to something to prevent
#											modulesd file generation


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
EXPORT_FUNCTIONS pkg_setup src_install pkg_postinst src_compile

DESCRIPTION="Based on the $ECLASS eclass"
SLOT=0
DEPEND="virtual/linux-sources
		sys-apps/sed
		sys-apps/module-init-tools"

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

generate_modulesd() {
	# This function will generate the neccessary modules.d file from the
	# information contained in the modules exported parms
	
	local selectedmodule selectedmodule_full selectedmodulevars parameter modinfop arg xifs temp
	local module_docs module_opts module_aliases module_config
	
	for arg in ${@}
	do
		selectedmodule_full="${arg}"
		# strip the directory
		selectedmodule="${selectedmodule_full/*\//}"	
		# convert the modulename to uppercase
		selectedmodule="$(echo ${selectedmodule} | tr '[:lower:]' '[:upper:]')"

		module_docs="MODULESD_${selectedmodule}_DOCS"
		module_aliases="$(eval echo \$\{#MODULESD_${selectedmodule}_ALIASES[*]\})"
		[ ${module_aliases} == 0 ] && unset module_aliases
		module_docs="${!module_docs}"
		modinfop="$(modinfo -p ${selectedmodule_full}.${KV_OBJ})"
		
		# By now we know if there is anything we can use to generate a file with
		# so unset empty vars and bail out if we find nothing.
		for parameter in ${!module_*}
		do
			[ -z "${!parameter}" ] && unset ${parameter}
		done
		[ -z "${!module_*}" -a -z "${modinfop}" ] && return

		#so now we can set the configfilevar
		module_config="${T}/modulesd-${selectedmodule}"
	
		# and being working on things.	
		ebegin "Preparing file for modules.d"
		echo  "# modules.d config file for ${selectedmodule}" >> ${module_config}
		echo  "# this file was automatically generated from linux-mod.eclass" >> ${module_config}
		for temp in ${module_docs}
		do
			echo "#  Please read ${temp/*\//} for more info" >> ${module_config}
		done

		if [ ${module_aliases} > 0 ];
		then
			echo >> ${module_config}
			echo  "# Internal Aliases - Do not edit" >> ${module_config}
			echo  "# ------------------------------" >> ${module_config}

			(( module_aliases-- ))
			for temp in $(seq 0 ${module_aliases})
			do
				echo "alias $(eval echo \$\{MODULESD_${selectedmodule}_ALIASES[$temp]\})" >> ${module_config}
			done
		fi

		# and then stating any module parameters defined from the module
		if [ -n "${modinfop}" ];
		then
			echo >> ${module_config}
			echo  "# Configurable module parameters" >> ${module_config}
			echo  "# ------------------------------" >> ${module_config}
		
			xifs="${IFS}"
			IFS="$(echo -en "\n\b")"
			for parameter in ${modinfop}
			do
				temp="$(echo ${parameter#*:} | grep -e " [0-9][ =]" | sed "s:.*\([01][= ]\).*:\1:")"
				if [ -n "${temp}" ];
				then
					module_opts="${module_opts} ${parameter%%:*}:${temp}"
				fi
				echo -e "# ${parameter%%:*}:\t${parameter#*:}" >> ${module_config}
			done
			IFS="${xifs}"
		fi
		
		# and any examples we can gather from them
		if [ -n "${module_opts}" ];
		then
			echo >> ${module_config}
			echo  "# For Example..." >> ${module_config}
			echo  "# ------------------------------" >> ${module_config}
			for parameter in ${module_opts}
			do
				echo "# options ${selectedmodule_full/*\//} ${parameter//:*}=${parameter//*:}" >> ${module_config}
			done
		fi
		
		# then we install it
		insinto /etc/modules.d
		newins ${module_config} ${selectedmodule_full/*\//}
		
		# and install any documentation we might have.
		[ -n "${module_docs}" ] && dodoc ${module_docs}
	done
	eend 0
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
	set_kvobj;
}

linux-mod_src_compile() {
	local modulename moduledir sourcedir moduletemp xarch i
	xarch="${ARCH}"
	unset ARCH
	
	BUILD_TARGETS=${BUILD_TARGETS:-clean module}

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
		
		if [ ! -f "${sourcedir}/.built" ];
		then
			cd ${sourcedir}
			einfo "Preparing ${modulename} module"
			emake ${BUILD_FIXES} ${BUILD_PARAMS} ${BUILD_TARGETS} || \
				die Unable to make ${BUILD_FIXES} ${BUILD_PARAMS} ${BUILD_TARGETS}.
			touch ${sourcedir}/.built
			cd ${OLDPWD}
		fi
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
		cd ${OLDPWD}
		
		[ -z "${NO_MODULESD}" ] && generate_modulesd ${sourcedir}/${modulename}
	done
}

linux-mod_pkg_postinst() {
	update_depmod;
	update_modules;
	display_postinst;
}
