# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/subversion.eclass,v 1.2 2004/01/26 08:46:29 hattya Exp $

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
# but currentry support http only.
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

	# http only...
	if [ "${ESVN_REPO_URI%%:*}" != "http" ]; then
		if [ -z "${ESVN_REPO_URI}" ]; then
			die "subversion.eclass: ESVN_REPO_URI is empty."

		else
			die "subversion.eclass: fetch from "${ESVN_REPO_URI%:*}" is not yet implemented."

		fi
	fi

	if [ ! -d "${ESVN_STORE_DIR}" ]; then
		mkdir -p "${ESVN_STORE_DIR}"
		einfo "created store directory: ${ESVN_STORE_DIR}"
		einfo
	fi

	cd "${ESVN_STORE_DIR}"
	addwrite "/etc/subversion"
	einfo

	if [ -z ${ESVN_REPO_URI##*/} ]; then
		ESVN_REPO_FIX="${ESVN_REPO_FIX%/}"
	fi

	ESVN_CO_DIR="${ESVN_PROJECT}/${ESVN_REPO_URI##*/}"

	if [ ! -d "${ESVN_CO_DIR}/.svn" ]; then
		# first check out
		einfo "subversion check out start -->"
		einfo
		einfo "check out from: ${ESVN_REPO_URI}"

		mkdir -p "${ESVN_PROJECT}"
		cd "${ESVN_PROJECT}"

		${ESVN_FETCH_CMD} "${ESVN_REPO_URI}"
		einfo "     stored in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"

	else
		# update working copy
		einfo "subversion update start -->"
		einfo
		einfo "   update from: ${ESVN_REPO_URI}"

		cd "${ESVN_CO_DIR}"
		${ESVN_UPDATE_CMD}
		einfo "    updated in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"
	fi

	# copy to the ${WORKDIR}
	cp -Rf "${ESVN_STORE_DIR}/${ESVN_CO_DIR}" "${WORKDIR}/${P}"
	einfo

}


## -- subversion_bootstrap() ------------------------------------------------ #

subversion_bootstrap() {

	if [ -n "${ESVN_BOOTSTRAP}" ]; then
		cd "${WORKDIR}/${P}"

		if [ -x "${ESVN_BOOTSTRAP}" ]; then
			./${ESVN_BOOTSTRAP}
		fi

	fi

}


## -- subversion_src_unpack() ------------------------------------------------ #

subversion_src_unpack() {

	subversion_svn_fetch
	subversion_bootstrap

}
