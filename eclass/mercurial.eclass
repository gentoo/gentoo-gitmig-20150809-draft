# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mercurial.eclass,v 1.1 2006/05/20 02:43:01 agriffis Exp $

# mercurial: Fetch sources from mercurial repositories, similar to cvs.eclass.
# To use this from an ebuild, set EHG_REPO_URI in your ebuild.  Then either
# leave the default src_unpack or call mercurial_src_unpack.

inherit eutils

EXPORT_FUNCTIONS src_unpack

DEPEND="dev-util/mercurial net-misc/rsync"
EHG_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/hg-src"

# This must be set by the ebuild
: ${EHG_REPO_URI:=}                                 # repository uri

# These can be set by the ebuild but are usually fine as-is
: ${EHG_CLONE_CMD:=hg clone}                        # clone cmd
: ${EHG_PULL_CMD:=hg pull -u}                       # pull cmd

# should be set but blank to prevent using $HOME/.hgrc
export HGRCPATH=

function mercurial_fetch {
	declare repo=${1:-$EHG_REPO_URI} proj=${2:-${PN/-hg}}
	repo=${repo%/}	# remove trailing slash
	[[ -n $repo ]] || die "EHG_REPO_URI is empty"

	if [[ ! -d ${EHG_STORE_DIR} ]]; then
		ebegin "create ${EHG_STORE_DIR}"
		addwrite / &&
			mkdir -p "${EHG_STORE_DIR}" &&
			chmod -f o+rw "${EHG_STORE_DIR}" &&
			export SANDBOX_WRITE="${SANDBOX_WRITE%:/}"
		eend $? || die
	fi

	cd "${EHG_STORE_DIR}" || die "can't chdir to ${EHG_STORE_DIR}"
	addwrite "$(pwd -P)"

	if [[ ! -d ${proj}/${repo##*/} ]]; then
		# first check out
		ebegin "${EHG_CLONE_CMD} ${repo}"
		mkdir -p "${proj}" &&
			chmod -f o+rw "${proj}" &&
			cd "${proj}" &&
			${EHG_CLONE_CMD} "${repo}" &&
			cd "${repo##*/}"
		eend $? || die
	else
		# update working copy
		ebegin "${EHG_PULL_CMD} ${repo}"
		cd "${proj}/${repo##*/}" &&
			${EHG_PULL_CMD}
		eend $? || die
	fi

	# use rsync instead of cp for --exclude
	ebegin "rsync to ${S}"
	mkdir -p "${S}" &&
		rsync -av --delete --exclude=.hg/ . "${S}"
	eend $? || die
}

function mercurial_src_unpack {
	mercurial_fetch
}
