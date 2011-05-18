# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/qd/qd-2.3.11.ebuild,v 1.1 2011/05/18 20:32:23 grozin Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Quad-double and double-double float arithmetics"
IUSE="fortran"
HOMEPAGE="http://crd.lbl.gov/~dhbailey/mpdist/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_URI="http://crd.lbl.gov/~dhbailey/mpdist/${P}.tar.gz"

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3.7-test.patch
	epatch "${FILESDIR}"/${P}-configure-version.patch
	epatch "${FILESDIR}"/${P}-docpath.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable fortran enable_fortran)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README.pdf TODO
	dosym /usr/include/qd/qd_real.h /usr/include/qd/qd.h
	dosym /usr/include/qd/dd_real.h /usr/include/qd/dd.h
}
