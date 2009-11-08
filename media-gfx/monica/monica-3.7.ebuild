# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/monica/monica-3.7.ebuild,v 1.4 2009/11/08 18:54:08 nixnut Exp $

inherit eutils

DESCRIPTION="Monica is a Monitor Calibration Tool"
HOMEPAGE="http://www.pcbypaul.com/software/monica.html"
SRC_URI="http://www.pcbypaul.com/software/dl/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="<x11-libs/fltk-2"
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
	emake CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin monica || die "dobin failed"
	dodoc authors ChangeLog news readme
}
