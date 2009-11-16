# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gnus/gnus-5.10.ebuild,v 1.11 2009/11/16 19:49:44 ulm Exp $

DESCRIPTION="Virtual for the Gnus newsreader"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( >=app-emacs/gnus-5.10.8
		>=virtual/emacs-22 )"

DEPEND="${RDEPEND}
	virtual/emacs"

pkg_setup () {
	local gvn
	gvn=$(emacs -batch -q --eval "
		(progn
		  (require 'gnus)
		  (princ gnus-version)
		  (if (< (gnus-continuum-version gnus-version)
				 (gnus-continuum-version \"Gnus v${PV}\"))
			  (error \"gnus-version too low\")))
		")

	if [ $? -eq 0 ]; then
		einfo "Gnus version \"${gvn}\" detected."
	else
		eerror "virtual/${P} requires at least Gnus version ${PV}."
		eerror "You should either install package app-emacs/gnus,"
		eerror "or use \"eselect emacs\" to select an Emacs version >= 22."
		die "Gnus version \"${gvn}\" is too low."
	fi
}
