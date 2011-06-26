# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/galib/galib-2.4.6.ebuild,v 1.6 2011/06/26 10:33:03 jlec Exp $

inherit eutils

MYPV="${PV//\./}"

DESCRIPTION="Library for genetic algorithms in C++ programs"
HOMEPAGE="http://lancet.mit.edu/ga/"
SRC_URI="http://lancet.mit.edu/ga/dist/galib${MYPV}.tgz"

LICENSE="GAlib"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

S="${WORKDIR}/galib${MYPV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-gcc4-gentoo.patch
}

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" || die "make failed"
}

src_install() {
	dodir /usr/lib /usr/include
	emake LIB_DEST_DIR="${D}"/usr/lib/ HDR_DEST_DIR="${D}"/usr/include/ install || die
	dohtml -r doc/*
	dodoc RELEASE-NOTES README
	cp -r examples "${D}"/usr/share/doc/${PF}/
}
