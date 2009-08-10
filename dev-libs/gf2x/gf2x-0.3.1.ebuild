# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gf2x/gf2x-0.3.1.ebuild,v 1.1 2009/08/10 21:17:50 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="C/C++ routines for fast arithmetic in GF(2)[x]"
HOMEPAGE="http://wwwmaths.anu.edu.au/~brent/gf2x.html"
SRC_URI="http://wwwmaths.anu.edu.au/~brent/ftp/trinom/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"
# tests need gmp and ntl, introducing a circle dependency
RESTRICT=test

src_prepare() {
	epatch "${FILESDIR}"/${P}-shared.patch
}

src_compile() {
	# turned off explicitely by upstream
	emake -j1 || die "emake failed"
}

src_install() {
	dolib.a libgf2x.a || die
	dolib.so libgf2x.so* || die
	dodoc Changelog README
}
