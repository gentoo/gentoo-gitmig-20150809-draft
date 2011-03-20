# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libassa/libassa-3.5.0.ebuild,v 1.9 2011/03/20 19:17:39 angelos Exp $

EAPI=3
inherit autotools eutils

DESCRIPTION="A networking library based on Adaptive Communication Patterns"
HOMEPAGE="http://libassa.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-dont-run-ldconfig.patch \
		"${FILESDIR}"/${P}-fix-tests.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	AT_M4DIR="${S}/macros"
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	find "${ED}" -name "*.la" -delete || die "failed to delete .la files"
}
