# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimcf/iiimcf-12.0.1_pre1891.ebuild,v 1.1 2004/09/13 20:06:03 usata Exp $

inherit iiimf

IUSE="X gtk emacs"
#IUSE="java"

DESCRIPTION="IIIMCF is a client framework for IIIMF"

KEYWORDS="~x86"
RDEPEND="X? ( =app-i18n/iiimxcf-${PV} )
	gtk? ( =app-i18n/iiimgcf-${PV} )
	emacs? ( =app-emacs/iiimecf-${PV} )"
#	java? ( virtual/jre )

pkg_setup() {

	use X \
	|| use gtk \
	|| use emacs \
	|| die "You must specify at least one of USE flags."
	# || use java \
}

src_compile() {

	return
}

src_install() {

	return
}
