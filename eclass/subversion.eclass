# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/subversion.eclass,v 1.8 2004/04/05 14:25:28 hattya Exp $

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

inherit eutils

ECLASS="subversion"
INHERITED="${INHERITED} ${ECLASS}"
ESVN="subversion.eclass"

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
# bootstrap script or command like autogen.sh or etc..
#
[ -z "${ESVN_BOOTSTRAP}" ] && ESVN_BOOTSTRAP=""


## -- ESVN_PATCHES:
#
# subversion eclass can apply pathces in subversion_bootstrap().
# you can use regexp in this valiable like *.diff or *.patch or etc.
# NOTE: this patches will apply before eval ESVN_BOOTSTRAP.
#
# the process of applying the patch is:
#   1. just epatch it, if the patch exists in the path.
#   2. scan it under FILESDIR and epatch it, if the patch exists in FILESDIR.
#   3. die.
#
[ -z "${ESVN_PATCHES}" ] && ESVN_PATCHES=""


## -- subversion_svn_fetch() ------------------------------------------------- #

subversion_svn_fetch() {

	# ESVN_REPO_URI is empty.
	[ -z "${ESVN_REPO_URI}" ] && die "${ESVN}: ESVN_REPO_URI is empty."

	# http and https only...
	case ${ESVN_REPO_URI%%:*} in
		http)	;;
		https)	;;
		*)
			die "${ESVN}: fetch from "${ESVN_REPO_URI%:*}" is not yet implemented."
			;;
	esac

	# every time
	addwrite "${ESVN_STORE_DIR}"
	addwrite "/etc/subversion"

	# -userpriv
	! has userpriv ${FEATURE} && addwrite "/root/.subversion"

	if [ ! -d "${ESVN_STORE_DIR}" ]; then
		mkdir -p "${ESVN_STORE_DIR}" || die "${ESVN}: can't mkdir ${ESVN_STORE_DIR}."
		chmod -f o+rw "${ESVN_STORE_DIR}" || die "${ESVN}: can't chmod ${ESVN_STORE_DIR}."
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
		einfo "   checkout from: ${ESVN_REPO_URI}"

		mkdir -p "${ESVN_PROJECT}" || die "${ESVN}: can't mkdir ${ESVN_PROJECT}."
		chmod -f o+rw "${ESVN_PROJECT}" || die "${ESVN}: can't chmod ${ESVN_PROJECT}."
		cd "${ESVN_PROJECT}"
		${ESVN_FETCH_CMD} "${ESVN_REPO_URI}" || die "${ESVN}: can't fetch from ${ESVN_REPO_URI}."
		einfo "   checkouted in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"

	else
		# update working copy
		einfo "subversion update start -->"
		einfo "   update from: ${ESVN_REPO_URI}"
		cd "${ESVN_CO_DIR}"

		local NOW=$(date +%s) UPDATE=$(date -r .svn/entries +%s) INTERVAL=3600
		if expr ${NOW} - ${UPDATE} \> ${INTERVAL} >/dev/null; then
			${ESVN_UPDATE_CMD} || die "${ESVN}: can't update from ${ESVN_REPO_URI}."
		else
			echo "Skip updating..."
		fi

		einfo "    updated in: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"

	fi

	# permission fix for NFS (root_squash) with -userpriv
	find ! -perm -o+rw -exec chmod o+rw {} \; 2>/dev/null

	# copy to the ${WORKDIR}
	cp -Rf "${ESVN_STORE_DIR}/${ESVN_CO_DIR}" "${S}" || die "${ESVN}: can't copy to ${S}."
	einfo "     copied to: ${S}"
	echo

}


## -- subversion_bootstrap() ------------------------------------------------ #

subversion_bootstrap() {

	cd "${S}"

	if [ "${ESVN_PATCHES}" ]; then
		einfo "apply paches -->"
		for PATCH in ${ESVN_PATCHES}; do
			if [ -f "${PATCH}" ]; then
				epatch ${PATCH}

			else
				for fPATCH in ${FILESDIR}/${PATCH}; do
					if [ -f "${fPATCH}" ]; then
						epatch ${fPATCH}

					else
						die "${ESVN}; ${PATCH} is not found"

					fi
				done
			fi
		done
		echo
	fi

	if [ "${ESVN_BOOTSTRAP}" ]; then
		einfo "begin bootstrap -->"
		if [ -f "${ESVN_BOOTSTRAP}" -a -x "${ESVN_BOOTSTRAP}" ]; then
			einfo "   bootstrap with a file: ${ESVN_BOOTSTRAP}"
			eval "./${ESVN_BOOTSTRAP}" || die "${ESVN}: can't execute ESVN_BOOTSTRAP."

		else
			einfo "   bootstrap with command: ESVN_BOOTSTRAP"
			eval "${ESVN_BOOTSTRAP}" || die "${ESVN}: can't eval ESVN_BOOTSTRAP."

		fi
	fi

}


## -- subversion_src_unpack() ------------------------------------------------ #

subversion_src_unpack() {

	subversion_svn_fetch || die "${ESVN}: unknown problem in subversion_svn_fetch()."
	subversion_bootstrap || die "${ESVN}: unknown problem in subversion_bootstrap()."

}
