# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/subversion.eclass,v 1.7 2004/03/01 16:37:31 hattya Exp $

## --------------------------------------------------------------------------- #
# Author: Akinori Hattori <hattya@gentoo.org>
# 
# The subversion eclass is written to fetch the software sources from
# subversion repositories like the cvs eclass.
#
#
# Description:
#   If you use this eclass, the ${S} is ${WORKDIR}/${P}.
#   It is necessary to define the ESVN_REPOURI variable at least.
#
## --------------------------------------------------------------------------- #


ECLASS="subversion"
INHERITED="${INHERITED} ${ECLASS}"

EXPORT_FUNCTIONS src_unpack

HOMEPAGE="http://subversion.tigris.org/"
DESCRIPTION="Based on the ${ECLASS} eclass"


## -- add subversion in DEPEND
#
newdepend "dev-util/subversion"


## -- ESVN_STORE_DIR:  subversion sources store directory
#
ESVN_STORE_DIR="${DISTDIR}/svn-src"


## -- ESVN_FETCH_CMD:  subversion fetch command
#
# default: svn checkout
#
[ -z "${ESVN_FETCH_CMD}" ]  && ESVN_FETCH_CMD="svn checkout"

## -- ESVN_UPDATE_CMD:  subversion update command
#
# default: svn update
#
[ -z "${ESVN_UPDATE_CMD}" ] && ESVN_UPDATE_CMD="svn update"


## -- ESVN_REPO_URI:  repository uri
#
# e.g. http://foo/trunk, svn://bar/trunk
# but currentry support http and https only.
#
[ -z "${ESVN_REPO_URI}" ]  && ESVN_REPO_URI=""


## -- ESVN_PROJECT:  project name of your ebuild
#
# subversion eclass will check out the subversion repository like:
#
#   ${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}
#
# so if you define ESVN_REPO_URI as http://svn.collab.net/repo/svn/trunk or
# http://svn.collab.net/repo/svn/trunk/. and PN is subversion-svn.
# it will check out like:
#
#   ${ESVN_STORE_DIR}/subversion/trunk
#
# default: ${PN/-svn}.
#
[ -z "${ESVN_PROJECT}" ] && ESVN_PROJECT="${PN/-svn}"


## -- ESVN_BOOTSTRAP:
#
# bootstrap script. like autogen.sh or etc..
#
[ -z "${ESVN_BOOTSTRAP}" ] && ESVN_BOOTSTRAP=""


## -- subversion_svn_fetch() ------------------------------------------------- #

subversion_svn_fetch() {

	# ESVN_REPO_URI is empty.
	[ -z "${ESVN_REPO_URI}" ] && die "subversion.eclass: ESVN_REPO_URI is empty."

	# http and https only...
	case ${ESVN_REPO_URI%%:*} in
		http)	;;
		https)	;;
		*)
			die "subversion.eclass: fetch from "${ESVN_REPO_URI%:*}" is not yet implemented."
			;;
	esac

	# every time
	addwrite "${ESVN_STORE_DIR}"
	addwrite "/etc/subversion"

	# -userpriv
	addwrite "/root/.subversion"

	if [ ! -d "${ESVN_STORE_DIR}" ]; then
		mkdir -p "${ESVN_STORE_DIR}" || die "subversion.eclass: can't mkdir ${ESVN_STORE_DIR}."
		chmod -f o+rw "${ESVN_STORE_DIR}" || die "subversion.eclass: can't chmod ${ESVN_STORE_DIR}."
		einfo "created store directory: ${ESVN_STORE_DIR}"
		einfo
	fi

	cd "${ESVN_STORE_DIR}"

	if [ -z ${ESVN_REPO_URI##*/} ]; then
		ESVN_REPO_FIX="${ESVN_REPO_URI%/}"
	else
		ESVN_REPO_FIX="${ESVN_REPO_URI}"
	fi

	ESVN_CO_DIR="${ESVN_PROJECT}/${ESVN_REPO_FIX##*/}"

	if [ ! -d "${ESVN_CO_DIR}/.svn" ]; then
		# first check out
		einfo "subversion check out start -->"
		einfo
		einfo "check out from: ${ESVN_REPO_URI}"

		mkdir -p "${ESVN_PROJECT}" || die "subversion.eclass: can't mkdir ${ESVN_PROJECT}."
		chmod -f o+rw "${ESVN_PROJECT}" || die "subversion.eclass: can't chmod ${ESVN_PROJECT}."
		cd "${ESVN_PROJECT}"
		${ESVN_FETCH_CMD} "${ESVN_REPO_URI}" || die "subversion.eclass: can't fetch from ${ESVN_REPO_URI}."
		einfo "     stored in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"

	else
		# update working copy
		einfo "subversion update start -->"
		einfo
		einfo "   update from: ${ESVN_REPO_URI}"

		cd "${ESVN_CO_DIR}"
		${ESVN_UPDATE_CMD} || die "subversion.eclass: can't update from ${ESVN_REPO_URI}."
		einfo "    updated in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"
	fi

	# permission fix
	chmod -Rf o+rw . 2>/dev/null

	# copy to the ${WORKDIR}
	cp -Rf "${ESVN_STORE_DIR}/${ESVN_CO_DIR}" "${WORKDIR}/${P}" || die "subversion.eclass: can't copy to ${WORKDIR}/${P}."
	einfo

}


## -- subversion_bootstrap() ------------------------------------------------ #

subversion_bootstrap() {

	if [ -n "${ESVN_BOOTSTRAP}" ]; then
		cd "${WORKDIR}/${P}"

		if [ -x "${ESVN_BOOTSTRAP}" ]; then
			einfo "begin bootstrap -->"
			./${ESVN_BOOTSTRAP} || die "subversion.eclass: can't bootstrap with ${ESVN_BOOTSTRAP}."
		fi

	fi

}


## -- subversion_src_unpack() ------------------------------------------------ #

subversion_src_unpack() {

	subversion_svn_fetch || die "subversion.eclass: unknown problem in subversion_svn_fetch()."
	subversion_bootstrap || die "subversion.eclass: unknown problem in subversion_bootstrap()."

}
