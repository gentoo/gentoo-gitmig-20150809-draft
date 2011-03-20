# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/monica/monica-3.7.ebuild,v 1.6 2011/03/20 20:14:46 jlec Exp $

EAPI="1"

inherit eutils toolchain-funcs

DESCRIPTION="Monica is a Monitor Calibration Tool"
HOMEPAGE="http://www.pcbypaul.com/software/monica.html"
SRC_URI="http://www.pcbypaul.com/software/dl/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/fltk:1"
RDEPEND="${DEPEND}
	x11-apps/xgamma"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.6-makefile-cleanup.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
	emake clean || die "emake clean failed"
}

src_compile() {
	emake CXX=$(tc-getCXX) LINK=$(tc-getCXX) CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin monica || die "dobin failed"
	dodoc authors ChangeLog news readme
}
