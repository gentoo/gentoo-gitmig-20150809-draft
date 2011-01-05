# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjpeg-turbo/libjpeg-turbo-1.0.90.1.ebuild,v 1.2 2011/01/05 14:44:52 ssuominen Exp $

EAPI=2
inherit autotools libtool

DESCRIPTION="MMX, SSE, and SSE2 SIMD accellerated jpeg library"
HOMEPAGE="http://sourceforge.net/projects/libjpeg-turbo/"
SRC_URI="http://dev.gentoo.org/~anarchy/dist/${P}.tar.bz2"

LICENSE="as-is LGPL-2.1 wxWinLL-3.1"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

RDEPEND="!media-libs/jpeg:0"
DEPEND="${RDEPEND}
	dev-lang/nasm"

S=${WORKDIR}/${PN}

src_prepare() {
	eautoreconf -fiv
	elibtoolize
}

src_configure() {
	econf \
		--with-jpeg8 \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUILDING.txt ChangeLog.txt example.c README-turbo.txt
	find "${D}" -name '*.la' -delete
}
