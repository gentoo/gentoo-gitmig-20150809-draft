# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/linux-mod.eclass,v 1.21 2005/01/16 12:24:23 johnm Exp $

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
		virtual/modutils"

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
		eend $?
	else
		ewarn
		ewarn "${KV_OUT_DIR}/System.map not found."
		ewarn "You must manually update the kernel module dependencies using depmod."
		eend 1
		ewarn
	fi
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

	for i in ${MODULE_IGNORE}
	do
		MODULE_NAMES=${MODULE_NAMES//${i}(*}
	done

	einfo "If you would like to load this module automatically upon boot"
	einfo "please type the following as root:"
	for i in ${MODULE_NAMES}
	do
		for n in $(find_module_params ${i})
		do
			eval ${n/:*}=${n/*:/}
		done
		libdir=${libdir:-misc}
		srcdir=${srcdir:-${S}}
		objdir=${objdir:-${srcdir}}
		
		einfo "    # echo \"${modulename}\" >> ${file}"
	done
	echo
}

find_module_params() {
	local matched_offset=0 matched_opts=0 test="${@}" temp_var result
	local i=0 y=0 z=0
	
	for((i=0; i<=${#test}; i++))
	do
		case ${test:${i}:1} in
			\()		matched_offset[0]=${i};;
			\:)		matched_opts=$((${matched_opts} + 1));
					matched_offset[${matched_opts}]="${i}";;
			\))		matched_opts=$((${matched_opts} + 1));
					matched_offset[${matched_opts}]="${i}";;
		esac
	done
	
	for((i=0; i<=${matched_opts}; i++))
	do
		# i			= offset were working on
		# y			= last offset
		# z			= current offset - last offset
		# temp_var	= temporary name
		case ${i} in
			0)	tempvar=${test:0:${matched_offset[0]}};;
			*)	y=$((${matched_offset[$((${i} - 1))]} + 1))
				z=$((${matched_offset[${i}]} - ${matched_offset[$((${i} - 1))]}));
				z=$((${z} - 1))
				tempvar=${test:${y}:${z}};;
		esac
		
		case ${i} in
			0)	result="${result} modulename:${tempvar}";;
			1)	result="${result} libdir:${tempvar}";;
			2)	result="${result} srcdir:${tempvar}";;
			3)	result="${result} objdir:${tempvar}";;
		esac
	done
	
	echo ${result}
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
	local modulename libdir srcdir objdir i n myARCH=${ARCH}
	unset ARCH
	
	BUILD_TARGETS=${BUILD_TARGETS:-clean module}
	
	for i in ${MODULE_IGNORE}
	do
		MODULE_NAMES=${MODULE_NAMES//${i}(*}
	done

	for i in ${MODULE_NAMES}
	do
		for n in $(find_module_params ${i})
		do
			eval ${n/:*}=${n/*:/}
		done
		libdir=${libdir:-misc}
		srcdir=${srcdir:-${S}}
		objdir=${objdir:-${srcdir}}
		
		if [ ! -f "${srcdir}/.built" ];
		then
			cd ${srcdir}
			einfo "Preparing ${modulename} module"
			emake ${BUILD_FIXES} ${BUILD_PARAMS} ${BUILD_TARGETS} \
				|| die "Unable to make \
				   ${BUILD_FIXES} ${BUILD_PARAMS} ${BUILD_TARGETS}."
			touch ${srcdir}/.built
			cd ${OLDPWD}
		fi
	done
	
	ARCH=${myARCH}
}

linux-mod_src_install() {
	local modulename libdir srcdir objdir i n
	
	for i in ${MODULE_IGNORE}
	do
		MODULE_NAMES=${MODULE_NAMES//${i}(*}
	done

	for i in ${MODULE_NAMES}
	do
		for n in $(find_module_params ${i})
		do
			eval ${n/:*}=${n/*:/}
		done
		libdir=${libdir:-misc}
		srcdir=${srcdir:-${S}}
		objdir=${objdir:-${srcdir}}

		einfo "Installing ${modulename} module"
		cd ${objdir}

		insinto /lib/modules/${KV_FULL}/${libdir}
		doins ${modulename}.${KV_OBJ}
		cd ${OLDPWD}
		
		[ -z "${NO_MODULESD}" ] && generate_modulesd ${objdir}/${modulename}
	done
}

linux-mod_pkg_postinst() {
	update_depmod;
	update_modules;
	display_postinst;
}
