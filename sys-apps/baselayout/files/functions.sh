# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout/files/functions.sh,v 1.1 2002/03/11 12:08:38 azarah Exp $

#setup a basic $PATH
[ -z "${PATH}" ] && PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin"

#daemontools dir
SVCDIR=/var/lib/supervise

#rc-scripts dir
svcdir=/mnt/.init.d

#size of $svcdir in KB
svcsize=1024

#different types of dependancies
deptypes="need use"

#different types of order deps
ordtypes="before after"

getcols() {
	echo "${2}"
}

COLS="$(stty size)"
COLS="$(getcols $COLS)"
COLS=$((${COLS} -7))
ENDCOL=$'\e[A\e['${COLS}'G'
#now, ${ENDCOL} will move us to the end of the column; irregardless of character width

NORMAL="\033[0m"
GOOD=$'\e[32;01m'
WARN=$'\e[33;01m'
BAD=$'\e[31;01m'
NORMAL=$'\e[0m'

HILITE=$'\e[36;01m'

ebegin() {
	echo -e " ${GOOD}*${NORMAL} ${*}..."
}

ewarn() {
	echo -e " ${WARN}*${NORMAL} ${*}"
}

eerror() {
	echo -e " ${BAD}*${NORMAL} ${*}"
}

einfo() {
	echo -e " ${GOOD}*${NORMAL} ${*}"
}

einfon() {
	echo -ne " ${GOOD}*${NORMAL} ${*}"
}

# void eend(int error, char *errstr)
#
eend() {
	if [ "$#" -eq 0 ] || [ "${1}" -eq 0 ]
	then
		echo -e "${ENDCOL}  \e[34;01m[ ${GOOD}ok \e[34;01m]${NORMAL}"
	else
		local returnme="${1}"
		if [ "$#" -ge 2 ]
		then
			shift
			eerror "${*}"
		fi
		echo -e "${ENDCOL}  \e[34;01m[ ${BAD}!! \e[34;01m]${NORMAL}"
		echo
		#extra spacing makes it easier to read
		return ${returnme}
	fi
}

# void ewend(int error, char *errstr)
#
ewend() {
	if [ "$#" -eq 0 ] || [ "${1}" -eq 0 ]
	then
		echo -e "${ENDCOL}  \e[34;01m[ ${GOOD}ok \e[34;01m]${NORMAL}"
	else
		local returnme="${1}"
		if [ "$#" -ge 2 ]
		then
			shift
			ewarn "${*}"
		fi
		echo -e "${ENDCOL}  \e[34;01m[ ${WARN}!! \e[34;01m]${NORMAL}"
		echo
		#extra spacing makes it easier to read
		return ${returnme}
	fi
}

# bool wrap_rcscript(full_path_and_name_of_rc-script)
#
#   return 0 if the script have no syntax errors in it
#
wrap_rcscript() {
	local retval=1

	( echo "function test_script() {" ; cat ${1}; echo "}" ) > ${svcdir}/foo.sh

	if source ${svcdir}/foo.sh &>/dev/null
	then
		test_script &>/dev/null
		retval=0
	fi
	rm -f ${svcdir}/foo.sh
	return ${retval}
}

# bool get_bootparam(param)
#
#   return 0 if gentoo=param was passed to the kernel
#
#   NOTE: you should always query the longer argument, for instance
#         if you have 'nodevfs' and 'devfs', query 'nodevfs', or 
#         results may be unpredictable.
#
#         if get_bootparam "nodevfs" -eq 0 ; then ....
#
get_bootparam() {
	local copt=""
	local parms=""
	local retval=1
	for copt in $(cat /proc/cmdline)
	do
		if [ "${copt%=*}" = "gentoo" ]
		then
			parms="${copt##*=}"
			#parse gentoo option
			if [ "$(eval echo \${parms/${1}/})" != "${parms}" ]
			then
				retval=0
			fi
		fi
	done
	return ${retval}
}

# Safer way to list the contents of a directory,
# as it do not have the "empty dir bug".
#
# char *dolisting(param)
#
#   print a list of the directory contents
#
#   NOTE: quote the params if they contain globs.
#         also, error checking is not that extensive ...
#
dolisting() {
	local x=""
	local y=""
	local tmpstr=""
	local mylist=""
	local mypath="${*}"

	if [ "${mypath%/\*}" != "${mypath}" ]
	then
		mypath="${mypath%/\*}"
	fi
	for x in ${mypath}
	do
		if [ ! -e ${x} ]
		then
			continue
		fi
		if [ ! -d ${x} ] && ( [ -L ${x} ] || [ -f ${x} ] )
		then
			mylist="${mylist} $(ls ${x})"
		else
			if [ "${x%/}" != "${x}" ]
			then
				x="${x%/}"
			fi
			cd ${x}
			tmpstr="$(ls)"
			for y in ${tmpstr}
			do
				mylist="${mylist} ${x}/${y}"
			done
		fi
	done
	echo "${mylist}"
}

# void save_options(char *option, char *optstring)
#
#   save the settings ("optstring") for "option"
#
save_options() {
	local myopts="${1}"
	shift
	if [ ! -d ${svcdir}/options/${myservice} ]
	then
		install -d -m0755 ${svcdir}/options/${myservice}
	fi
	echo "${*}" > ${svcdir}/options/${myservice}/${myopts}
}

# char *get_options(char *option)
#
#   get the "optstring" for "option" that was saved
#   by calling the save_options function
#
get_options() {
	if [ -f ${svcdir}/options/${myservice}/${1} ]
	then
		cat ${svcdir}/options/${myservice}/${1}
	fi
}


# vim:ts=4
