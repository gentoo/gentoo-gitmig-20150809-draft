# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Jason Shoemaker <kutsuya@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/zproduct.eclass,v 1.6 2003/04/04 00:53:12 kutsuya Exp $

# This eclass is designed to streamline the construction of
# ebuilds for new zope products

# 2003/04/03 - Added DOTTXT_PROTEXT variable..
#            - Removed from EXPORT_FUNCTIONS: dottxt_protect, dottxt_unprotect

ECLASS=zproduct
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_install pkg_prerm pkg_postinst pkg_config

DESCRIPTION="This is a zope product"
HOMEPAGE=""
SRC_URI=""
DEPEND=""
RDEPEND=">=net-zope/zope-2.6.0-r2
	app-admin/zprod-manager"
IUSE=""
SLOT="0"
KEYWORDS="x86"
S=${WORKDIR}

ZI_DIR="${ROOT}/var/lib/zope/"
ZP_DIR="${ROOT}/usr/share/zproduct"
DOT_ZFOLDER_FPATH="${ZP_DIR}/${PF}/.zfolder.lst"
DOTTXT_PROTECT="refresh.txt version.txt"


# Temporarily rename .txt files that we don't want ripped out by do_doc.
# Parameters:
#   $1 = list of .txt files(without .txt) to protect from do_docs 
#		 (can be empty)
#   $2 = src
# Returns: a list of path(s) of where item should go, along with tmp file name

dottxt_protect()
{
	local RESULT=0
	local LIST_MKTEMP=""
  
	[ -z "$1" ] && return 
	for N in $1 ; do
		if [ -f "${2}/${N}" ] ; then
			TMPFILE=$(mktemp ${S}/${N}.XXXXXXXXXX) || die 'mktemp error'
			LIST_MKTEMP="${2}/$(basename $TMPFILE) $LIST_MKTEMP"
			mv -f ${2}/$N $TMPFILE
		fi
	done
	echo "$LIST_MKTEMP"
}

# Parameters:
#   $1 = list of tmp files(produced by dottxt_protect)

dottxt_unprotect()
{
	local N=""
	for N in $1 ; do
		local SRC=${S}/$(basename $N)
		mv -f ${SRC} ${N%.*}
	done
}

zproduct_src_install()
{
	## Assume that folders or files that shouldn't be installed
	#  in the zproduct directory have been already been removed.
    ## Assume $S set to the parent directory of the zproduct(s).

	debug-print-function ${FUNCNAME} ${*}
	[ -n "${ZPROD_LIST}" ] || die "ZPROD_LIST isn't defined."
	[ -z "${1}" ] && zproduct_src_install all

	# set defaults
	into ${ZP_DIR}
	dodir ${ZP_DIR}/${PF}

	while [ -n "$1" ] ; do
		case ${1} in
			do_zpfolders)
				## Create .zfolders.lst from $ZPROD_LIST.
				debug-print-section do_zpfolders 
				for N in ${ZPROD_LIST} ; do
					echo ${N} >> ${D}/${DOT_ZFOLDER_FPATH}
				done ;;					
			do_docs)
				#*Moves txt docs 
				debug-print-section do_docs 
				LIST_OUTER="$(dottxt_protect "$DOTTXT_PROTECT" ${S})"
				docinto / 
				dodoc *.txt >/dev/null
				rm -f *.txt
				dodoc *.txt.* >/dev/null
				rm -f *.txt.*
				dottxt_unprotect "$LIST_OUTER"
				for N in ${ZPROD_LIST} ; do
					LIST_INNER="$(dottxt_protect "$DOTTXT_PROTECT" ${S}/${N})"
					docinto ${N}
					dodoc ${N}/*.txt >/dev/null
					rm -f ${N}/*.txt
					dodoc ${N}/*.txt.* >/dev/null
					rm -f ${N}/*.txt.*
					if [ -d "${N}/docs" ] ; then
						docinto ${N}/docs
						dodoc ${N}/docs/*
						rm -Rf ${N}/docs
					fi
					dottxt_unprotect "$LIST_INNER" $N
				done ;;
			do_install)
				debug-print-section do_install
				# Copy everything that's left to ${D}${ZP_DIR}
				cp -a ${S}/* ${D}/${ZP_DIR}/${PF} ;;
						
			all)
				debug-print-section all 
 				zproduct_src_install do_zpfolders do_docs do_install ;;
		esac
		shift
	done	
	debug-print "${FUNCNAME}: result is ${RESULT}"
}

zproduct_pkg_postinst()
{
    #*check for multiple zinstances, if several display install help msg.

    #*Use zprod-update to install this zproduct to the default zinstance.
	debug-print-function ${FUNCNAME} ${*}
	chown -R zope:root ${ZP_DIR}/${PF}
	einfo ">>> Installing ${PF} into the \"$(zope-config --zidef-get)\" zinstance..."
	${ROOT}/usr/sbin/zprod-manager add ${ZP_DIR}/${PF} 
}

zproduct_pkg_prerm()
{
	# remove this zproduct from all zinstances.
	# process zinstance.lst and proceed with zprod-update del
	debug-print-function ${FUNCNAME} ${*}
	ewarn "Uninstalling from all zinstances..."
	ZINST_LST=$(ls /var/lib/zope/)
	if [ "${ZINST_LST}" ] ; then
		for N in ${ZINST_LST} ; do
			${ROOT}/usr/sbin/zprod-manager del ${ZP_DIR}/${PF} ${ZI_DIR}${N}
		done
	fi
}

# Add this zproduct to the top zinstance.

zproduct_pkg_config()
{
	einfo "To add zproducts to other zinstances execute:"
	einfo "\tzprod-manager add"
}
