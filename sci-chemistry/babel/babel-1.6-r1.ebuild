# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/babel/babel-1.6-r1.ebuild,v 1.4 2011/12/16 13:04:00 jlec Exp $

EAPI=4

inherit eutils

DESCRIPTION="Interconvert file formats used in molecular modeling"
HOMEPAGE="http://smog.com/chem/babel/"
SRC_URI="http://smog.com/chem/babel/files/${P}.tar.Z"

SLOT="0"
LICENSE="as-is"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

#Doesn't really seem to depend on anything (?)
DEPEND="!sci-chemistry/openbabel"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc32.diff \
		"${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}

src_install () {
	default

	insinto /usr/share/${PN}
	doins *.lis

	doenvd "${FILESDIR}"/10babel
	dodoc README.1ST
}
