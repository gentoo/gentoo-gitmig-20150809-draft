# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Jason Shoemaker <kutsuya@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/zproduct.eclass,v 1.7 2003/06/26 15:52:05 kutsuya Exp $

# This eclass is designed to streamline the construction of
# ebuilds for new zope products

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
KEYWORDS="x86 ppc"
S=${WORKDIR}

ZI_DIR="${ROOT}/var/lib/zope/"
ZP_DIR="${ROOT}/usr/share/zproduct"
DOT_ZFOLDER_FPATH="${ZP_DIR}/${PF}/.zfolder.lst"

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
				docs_move
				for ZPROD in ${ZPROD_LIST} ; do
					docs_move ${ZPROD}/
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

docs_move()
{
    # if $1 == "/", then this breaks.
	if [ -n "$1" ] ; then
		docinto $1
	else 
		docinto /
	fi
    dodoc $1HISTORY.txt $1README{.txt,} $1INSTALL{.txt,} > /dev/null
	dodoc $1AUTHORS $1COPYING $1CREDITS.txt $1TODO{.txt,} > /dev/null
	dodoc $1LICENSE{.GPL,.txt,} $1CHANGES{.txt,} > /dev/null
	dodoc $1DEPENDENCIES.txt $1FAQ.txt $1UPGRADE.txt > /dev/null
	for item in ${MYDOC} ; do
		dodoc ${1}${item} > /dev/null
	done
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

# This function is deprecated! Still used, until a new system developed.

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
