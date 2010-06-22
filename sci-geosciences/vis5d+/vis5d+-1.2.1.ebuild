# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/vis5d+/vis5d+-1.2.1.ebuild,v 1.4 2010/06/22 13:11:24 jlec Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="3dimensional weather modeling software"
HOMEPAGE="http://vis5d.sourceforge.net"
SRC_URI="mirror://sourceforge/vis5d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# amd64: Function `vis5d_get_dtx' implicitly converted to pointer at graphics.ogl.c:1355
KEYWORDS="-amd64 x86"
IUSE=""

RDEPEND="
	dev-lang/tcl
	>=sci-libs/netcdf-3.5
	x11-libs/libX11
	virtual/glu"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-round.patch
}

src_configure() {
	econf \
		--without-mixkit \
		--enable-threads
}

src_compile() {
	emake \
		CC="$(tc-getCC)"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS ChangeLog PORTING AUTHORS
}
