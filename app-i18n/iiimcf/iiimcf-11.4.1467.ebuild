# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimcf/iiimcf-11.4.1467.ebuild,v 1.2 2003/09/14 01:48:07 usata Exp $

inherit iiimf

IUSE="X gtk emacs"
#IUSE="java"

DESCRIPTION="IIIMCF is a client framework for IIIMF"

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

	: # This is a meta package
}

src_install() {

	: # This is a meta package
}
