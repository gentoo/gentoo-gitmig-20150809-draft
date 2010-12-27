# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/emacs-cedet/emacs-cedet-0.ebuild,v 1.2 2010/12/27 10:24:43 ulm Exp $

DESCRIPTION="Virtual for the Collection of Emacs Development Environment Tools"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

# CEDET is included with GNU Emacs 23.2 or later.
RDEPEND="|| ( app-emacs/cedet
		>=app-editors/emacs-23.2
		>=app-editors/emacs-vcs-23.2 )"

DEPEND="${RDEPEND}
	virtual/emacs"

pkg_setup () {
	# Test if CEDET is available with the actual (eselected) Emacs.
	if ! emacs -batch -q --eval "(require 'cedet)"; then
		eerror "virtual/${P} requires Emacs with CEDET."
		eerror "You should either install package app-emacs/cedet,"
		eerror "or use \"eselect emacs\" to select an Emacs version >= 23.2."
		die "CEDET not found."
	fi
}
