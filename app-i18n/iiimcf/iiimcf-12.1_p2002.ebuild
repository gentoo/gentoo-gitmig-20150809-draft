# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimcf/iiimcf-12.1_p2002.ebuild,v 1.1 2005/03/30 17:14:17 usata Exp $

inherit iiimf

IUSE="X gtk emacs"
#IUSE="java"

DESCRIPTION="IIIMCF is a client framework for IIIMF"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

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
