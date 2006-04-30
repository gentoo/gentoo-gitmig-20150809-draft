# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/subversion.eclass,v 1.30 2006/04/30 09:15:03 hattya Exp $

## --------------------------------------------------------------------------- #
# Author: Akinori Hattori <hattya@gentoo.org>
#
# The subversion eclass is written to fetch the software sources from
# subversion repositories like the cvs eclass.
#
#
# Description:
#   If you use this eclass, the ${S} is ${WORKDIR}/${P}.
#   It is necessary to define the ESVN_REPO_URI variable at least.
#
## --------------------------------------------------------------------------- #

inherit eutils

ESVN="subversion.eclass"

EXPORT_FUNCTIONS src_unpack

HOMEPAGE="http://subversion.tigris.org/"
DESCRIPTION="Based on the ${ECLASS} eclass"


## -- add subversion in DEPEND
#
DEPEND="dev-util/subversion"


## -- ESVN_STORE_DIR:  subversion sources store directory
#
ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/svn-src"


## -- ESVN_FETCH_CMD:  subversion fetch command
#
ESVN_FETCH_CMD="svn checkout"

## -- ESVN_UPDATE_CMD:  subversion update command
#
ESVN_UPDATE_CMD="svn update"


## -- ESVN_OPTIONS:
#
# the options passed to checkout or update.
#
[ -z "${ESVN_OPTIONS}" ] && ESVN_OPTIONS=


## -- ESVN_REPO_URI:  repository uri
#
# e.g. http://foo/trunk, svn://bar/trunk
#
# supported protocols:
#   http://
#   https://
#   svn://
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

function subversion_svn_fetch() {

	local ESVN_CO_DIR

	# ESVN_REPO_URI is empty.
	[ -z "${ESVN_REPO_URI}" ] && die "${ESVN}: ESVN_REPO_URI is empty."

	# check for the protocol.
	case ${ESVN_REPO_URI%%:*} in
		http|https)
			if built_with_use dev-util/subversion nowebdav; then
				eerror "In order to emerge this package, you need to"
				eerror "re-emerge subversion with USE=-nowebdav"
				die "Please run 'USE=-nowebdav emerge subversion'"
			fi
			;;
		svn)	;;
		*)
			die "${ESVN}: fetch from "${ESVN_REPO_URI%:*}" is not yet implemented."
			;;
	esac

	if [ ! -d "${ESVN_STORE_DIR}" ]; then
		debug-print "${FUNCNAME}: initial checkout. creating subversion directory"

		addwrite /
		mkdir -p "${ESVN_STORE_DIR}"      || die "${ESVN}: can't mkdir ${ESVN_STORE_DIR}."
		chmod -f o+rw "${ESVN_STORE_DIR}" || die "${ESVN}: can't chmod ${ESVN_STORE_DIR}."
		export SANDBOX_WRITE="${SANDBOX_WRITE%%:/}"
	fi

	cd -P "${ESVN_STORE_DIR}" || die "${ESVN}: can't chdir to ${ESVN_STORE_DIR}"
	ESVN_STORE_DIR=${PWD}

	# every time
	addwrite "/etc/subversion"
	addwrite "${ESVN_STORE_DIR}"

	if ! has userpriv ${FEATURES}; then
		# -userpriv
		addwrite "/root/.subversion"

	else
		# +userpriv
		ESVN_OPTIONS="${ESVN_OPTIONS} --config-dir ${ESVN_STORE_DIR}/.subversion"

	fi

	[ -z "${ESVN_REPO_URI##*/}" ] && ESVN_REPO_URI="${ESVN_REPO_URI%/}"
	ESVN_CO_DIR="${ESVN_PROJECT}/${ESVN_REPO_URI##*/}"

	debug-print "${FUNCNAME}: ESVN_OPTIONS = \"${ESVN_OPTIONS}\""

	if [ ! -d "${ESVN_CO_DIR}/.svn" ]; then
		# first check out
		einfo "subversion check out start -->"
		einfo "     repository: ${ESVN_REPO_URI}"

		mkdir -p "${ESVN_PROJECT}"      || die "${ESVN}: can't mkdir ${ESVN_PROJECT}."
		chmod -f o+rw "${ESVN_PROJECT}" || die "${ESVN}: can't chmod ${ESVN_PROJECT}."
		cd "${ESVN_PROJECT}"
		${ESVN_FETCH_CMD} ${ESVN_OPTIONS} "${ESVN_REPO_URI}" || die "${ESVN}: can't fetch from ${ESVN_REPO_URI}."

	else
		# update working copy
		einfo "subversion update start -->"
		einfo "     repository: ${ESVN_REPO_URI}"

		cd "${ESVN_CO_DIR}"
		${ESVN_UPDATE_CMD} ${ESVN_OPTIONS} || die "${ESVN}: can't update from ${ESVN_REPO_URI}."

	fi

	einfo "   working copy: ${ESVN_STORE_DIR}/${ESVN_CO_DIR}"

	# export to the ${WORKDIR}
	# "svn export" has a bug.  see http://bugs.gentoo.org/119236
	#svn export "${ESVN_STORE_DIR}/${ESVN_CO_DIR}" "${S}" || die "${ESVN}: can't export to ${S}."
	rsync -a --exclude=".svn" "${ESVN_STORE_DIR}/${ESVN_CO_DIR}/" "${S}" || die "${ESVN}: can't export to ${S}."
	echo

}


## -- subversion_bootstrap() ------------------------------------------------ #

function subversion_bootstrap() {

	local patch lpatch

	cd "${S}"

	if [ "${ESVN_PATCHES}" ]; then
		einfo "apply patches -->"

		for patch in ${ESVN_PATCHES}; do
			if [ -f "${patch}" ]; then
				epatch ${patch}

			else
				for lpatch in ${FILESDIR}/${patch}; do
					if [ -f "${lpatch}" ]; then
						epatch ${lpatch}

					else
						die "${ESVN}; ${patch} is not found"

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
			einfo "   bootstrap with commands: ${ESVN_BOOTSTRAP}"
			eval "${ESVN_BOOTSTRAP}" || die "${ESVN}: can't eval ESVN_BOOTSTRAP."

		fi
	fi

}


## -- subversion_src_unpack() ------------------------------------------------ #

function subversion_src_unpack() {

	subversion_svn_fetch || die "${ESVN}: unknown problem in subversion_svn_fetch()."
	subversion_bootstrap || die "${ESVN}: unknown problem in subversion_bootstrap()."

}
