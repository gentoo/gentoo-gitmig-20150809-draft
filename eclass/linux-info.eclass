# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/linux-info.eclass,v 1.5 2004/12/01 18:08:57 johnm Exp $
#
# This eclass provides functions for querying the installed kernel
# source version, selected kernel options etc.
#

ECLASS=linux-info
INHERITED="$INHERITED $ECLASS"

# Overwritable environment Var's
# ---------------------------------------
KERNEL_DIR="${KERNEL_DIR:-/usr/src/linux}"

# File Functions
# ---------------------------------------

# getfilevar accepts 2 vars as follows:
# getfilevar <VARIABLE> <CONFIGFILE>

getfilevar() {
local	ERROR curpwd
	ERROR=0
	
	[ -z "${1}" ] && ERROR=1
	[ ! -f "${2}" ] && ERROR=1

	if [ "${ERROR}" = 1 ]
	then
		eerror "getfilevar requires 2 variables, with the second a valid file."
		eerror "   getfilevar <VARIABLE> <CONFIGFILE>"
	else
		curpwd="${PWD}"
		cd $(dirname ${2})
		echo $(echo -e "include $(basename ${2})\ne:\n\t@echo \$(${1})" | make -f - e)
	 	cd ${curpwd}
	#	grep -e "^$1[= ]" $2 | sed 's: = :=:' | cut -d= -f2-
	fi
}

getfilevar_isset() {
local	RESULT
	RESULT="$(getfilevar ${1} ${2})"
	[ "${RESULT}" = "m" -o "${RESULT}" = "y" ] && return 0 || return 1
}

getfilevar_ismodule() {
local	RESULT
	RESULT="$(getfilevar ${1} ${2})"
	[ "${RESULT}" = "m" ] && return 0 || return 1
}

getfilevar_isbuiltin() {
local	RESULT
	RESULT="$(getfilevar ${1} ${2})"
	[ "${RESULT}" = "y" ] && return 0 || return 1
}

# Versioning Functions
# ---------------------------------------

# kernel_is returns true when the version is the same as the passed version
#
# For Example where KV = 2.6.9
# kernel_is 2 4 	returns false
# kernel_is 2		returns true
# kernel_is 2 6		returns true
# kernel_is 2 6 8	returns false
# kernel_is 2 6 9	returns true
#
# got the jist yet?

kernel_is() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	local RESULT
	RESULT=1
	
	if [ -n "${1}" ]
	then
		[ "${1}" = "${KV_MAJOR}" ] && RESULT=0
	fi
	
	if [ -n "${2}" ]
	then
		RESULT=1
		[ "${2}" = "${KV_MINOR}" ] && RESULT=0
	fi
	
	if [ -n "${3}" ]
	then
		RESULT=1
		[ "${3}" = "${KV_PATCH}" ] && RESULT=0
	fi
	return ${RESULT}
}

get_version() {
	local kbuild_output
	
	# no need to execute this twice assuming KV_FULL is populated.
	# we can force by unsetting KV_FULL
	[ -n "${KV_FULL}" ] && return

	# if we dont know KV_FULL, then we need too.
	# make sure KV_DIR isnt set since we need to work it out via KERNEL_DIR
	unset KV_DIR

	# KV_DIR will contain the full path to the sources directory we should use
	einfo "Determining the location of the kernel source code"
	[ -h "${KERNEL_DIR}" ] && KV_DIR="$(readlink -f ${KERNEL_DIR})"
	[ -d "${KERNEL_DIR}" ] && KV_DIR="${KERNEL_DIR}"
	
	if [ -z "${KV_DIR}" ]
	then
		eerror "Unable to find kernel sources at ${KERNEL_DIR}"
		die
	fi
	
	# OK so now we know our sources directory, but they might be using
	# KBUILD_OUTPUT, and we need this for .config and localversions-*
	# so we better find it eh?
	# do we pass KBUILD_OUTPUT on the CLI?
	OUTPUT_DIR="${OUTPUT_DIR:-${KBUILD_OUTPUT}}"
	
	# Or maybe KBUILD_OUTPUT is set in Makefile?
	kbuild_output="$(getfilevar KBUILD_OUTPUT ${KV_DIR}/Makefile)"
	OUTPUT_DIR="${OUTPUT_DIR:-${kbuild_output}}"
	
	# And contrary to existing functions I feel we shouldn't trust the
	# directory name to find version information as this seems insane.
	# so we parse ${KV_DIR}/Makefile
	KV_MAJOR="$(getfilevar VERSION ${KV_DIR}/Makefile)"
	KV_MINOR="$(getfilevar PATCHLEVEL ${KV_DIR}/Makefile)"
	KV_PATCH="$(getfilevar SUBLEVEL ${KV_DIR}/Makefile)"
	KV_EXTRA="$(getfilevar EXTRAVERSION ${KV_DIR}/Makefile)"
	
	# and in newer versions we can also pull LOCALVERSION if it is set.
	# but before we do this, we need to find if we use a different object directory.
	# This *WILL* break if the user is using localversions, but we assume it was
	# caught before this if they are.
	[ "${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.${KV_EXTRA}" == "$(uname -r)" ] && \
		OUTPUT_DIR="/lib/modules/${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.${KV_EXTRA}/build"

	[ -h "${OUTPUT_DIR}" ] && KV_OUT_DIR="$(readlink -f ${OUTPUT_DIR})"
	[ -d "${OUTPUT_DIR}" ] && KV_OUT_DIR="${OUTPUT_DIR}"
	if [ -n "${KV_OUT_DIR}" ];
	then
		einfo "Found kernel object directory:"
		einfo "    ${KV_OUT_DIR}"
		
		KV_LOCAL="$(cat ${KV_OUT_DIR}/localversion* 2>/dev/null)"
	fi
	# and if we STILL haven't got it, then we better just set it to KV_DIR
	KV_OUT_DIR="${KV_OUT_DIR:-${KV_DIR}}"
	
	KV_LOCAL="${KV_LOCAL}$(cat ${KV_DIR}/localversion* 2>/dev/null)"
	KV_LOCAL="${KV_LOCAL}$(getfilevar CONFIG_LOCALVERSION ${KV_OUT_DIR}/.config | sed 's:"::g')"
	
	# And we should set KV_FULL to the full expanded version
	KV_FULL="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}${KV_EXTRA}${KV_LOCAL}"
	
	if [ -z "${KV_FULL}" ]
	then
		eerror "We are unable to find a usable kernel source tree in ${KV_DIR}"
		eerror "Please check a kernel source exists in this directory."
		die
	else
		einfo "Found kernel source directory:"
		einfo "    ${KV_DIR}"
		einfo "with sources for kernel version:"
		einfo "    ${KV_FULL}"
	fi
}




# ebuild check functions
# ---------------------------------------

check_kernel_built() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	if [ ! -f "${KV_OUT_DIR}/System.map" ]
	then
		eerror "These sources have not yet been compiled."
		eerror "We cannot build against an uncompiled tree."
		eerror "To resolve this, please type the following:"
		eerror
		eerror "# cd ${KV_DIR}"
		eerror "# make oldconfig"
		eerror "# make bzImage modules modules_install"
		eerror
		eerror "Then please try merging this module again."
		die "Kernel sources need compiling first"
	fi
}

check_modules_supported() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	getfilevar_isset CONFIG_MODULES ${KV_OUT_DIR}/.config
	if [ "$?" != 0 ]
	then
		eerror "These sources do not support loading external modules."
		eerror "to be able to use this module please enable \"Loadable modules support\""
		eerror "in your kernel, recompile and then try merging this module again."
		die No support for external modules in ${KV_FULL} config
	fi
}

check_extra_config() {
local	config negate error

	# if we haven't determined the version yet, we need too.
	get_version;

	einfo "Checking for suitable kernel configuration options"
	for config in ${CONFIG_CHECK}
	do
		negate="${config:0:1}"
		if [ "${negate}" == "!" ];
		then
			config="${config:1}"
			if getfilevar_isset ${config} ${KV_OUT_DIR}/.config ;
			then
				eerror "  ${config}:\tshould not be set in the kernel configuration, but it is."
				error=1
			fi
		else
			if ! getfilevar_isset ${config} ${KV_OUT_DIR}/.config ;
			then
				eerror "  ${config}:\tshould be set in the kernel configuration, but isn't"
				error=1
			fi
		fi
	done

	if [ -n "${error}" ] ;
	then
		eerror "Please check to make sure these options are set correctly."
		eerror "Once you have satisfied these options, please try merging"
		eerror "this package again."
		die Incorrect kernel configuration options
	fi
}

check_zlibinflate() {
	# if we haven't determined the version yet, we need too.
	get_version;
	
	# although I restructured this code - I really really really dont support it!

	# bug #27882 - zlib routines are only linked into the kernel
	# if something compiled into the kernel calls them
	#
	# plus, for the cloop module, it appears that there's no way
	# to get cloop.o to include a static zlib if CONFIG_MODVERSIONS
	# is on
	
local	INFLATE
local	DEFLATE

	einfo "Determining the usability of ZLIB_INFLATE support in your kernel"
	
	ebegin "checking ZLIB_INFLATE"
	getfilevar_isbuiltin CONFIG_ZLIB_INFLATE ${KV_DIR}/.config
	eend $?
	[ "$?" != 0 ] && die
	
	ebegin "checking ZLIB_DEFLATE"
	getfilevar_isbuiltin CONFIG_ZLIB_DEFLATE ${KV_DIR}/.config
	eend $?
	[ "$?" != 0 ] && die
	
	
	local LINENO_START
	local LINENO_END
	local SYMBOLS
	local x
	
	LINENO_END="$(grep -n 'CONFIG_ZLIB_INFLATE y' ${KV_DIR}/lib/Config.in | cut -d : -f 1)"
	LINENO_START="$(head -n $LINENO_END ${KV_DIR}/lib/Config.in | grep -n 'if \[' | tail -n 1 | cut -d : -f 1)"
	(( LINENO_AMOUNT = $LINENO_END - $LINENO_START ))
	(( LINENO_END = $LINENO_END - 1 ))
	SYMBOLS="$(head -n $LINENO_END ${KV_DIR}/lib/Config.in | tail -n $LINENO_AMOUNT | sed -e 's/^.*\(CONFIG_[^\" ]*\).*/\1/g;')"

	# okay, now we have a list of symbols
	# we need to check each one in turn, to see whether it is set or not
	for x in $SYMBOLS ; do
		if [ "${!x}" = "y" ]; then
			# we have a winner!
			einfo "${x} ensures zlib is linked into your kernel - excellent"
			return 0
		fi
	done
	
	eerror
	eerror "This kernel module requires ZLIB library support."
	eerror "You have enabled zlib support in your kernel, but haven't enabled"
	eerror "enabled any option that will ensure that zlib is linked into your"
	eerror "kernel."
	eerror
	eerror "Please ensure that you enable at least one of these options:"
	eerror

	for x in $SYMBOLS ; do
		eerror "  * $x"
	done

	eerror
	eerror "Please remember to recompile and install your kernel, and reboot"
	eerror "into your new kernel before attempting to load this kernel module."

	die "Kernel doesn't include zlib support"
}
