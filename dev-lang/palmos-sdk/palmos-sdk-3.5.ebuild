# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/palmos-sdk/palmos-sdk-3.5.ebuild,v 1.4 2004/06/07 20:34:54 agriffis Exp $

DESCRIPTION="The static libraries and header files needed for developing PalmOS applications."
HOMEPAGE="http://www.palmos.com/"
LICENSE="Palm-SDK"

SLOT="3.5"
KEYWORDS="~x86"
DEPEND="dev-lang/prc-tools"
SRC_URI="sdk35.tar.gz sdk35-update1.tar.gz
	doc? ( sdk35-docs.tar.gz sdk35-examples.tar.gz )"
IUSE="doc"
RESTRICT="nostrip fetch"
S=${WORKDIR}

pkg_nofetch() {
	typeset a

	einfo "Please download the following files from"
	einfo "http://www.palmos.com/cgi-bin/sdk35.cgi"
	einfo "and put them in ${DISTDIR}, then emerge this package again."
	for a in ${A}; do
		einfo "  ${a}"
	done
}

src_install() {
	typeset base=/opt/palmdev/sdk-${SLOT}

	dodir ${base} || die
	mv Palm\ OS\ 3.5\ Support/GCC\ Libraries ${D}/${base}/lib || die
	mv Palm\ OS\ 3.5\ Support/Incs ${D}/${base}/include || die

	if use doc; then
		mv docs ${D}/${base}/Documentation || die
		mv Examples ${D}/${base}/Documentation || die
	fi

}

pkg_postinst() {
	palmdev-prep || eerror "Error running palmdev-prep :-("
}
