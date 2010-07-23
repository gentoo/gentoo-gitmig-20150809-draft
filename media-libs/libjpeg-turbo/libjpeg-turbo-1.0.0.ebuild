# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjpeg-turbo/libjpeg-turbo-1.0.0.ebuild,v 1.3 2010/07/23 23:17:23 ssuominen Exp $

EAPI=2
inherit libtool

DESCRIPTION="MMX, SSE, and SSE2 SIMD accellerated jpeg library"
HOMEPAGE="http://sourceforge.net/projects/libjpeg-turbo/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is LGPL-2.1 wxWinLL-3.1"
SLOT="0"
KEYWORDS=""
IUSE="static-libs"

RDEPEND="!media-libs/jpeg:0
	!media-libs/jpeg:62"
DEPEND="${RDEPEND}
	dev-lang/nasm"

src_prepare() {
	elibtoolize
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUILDING.txt ChangeLog.txt example.c README-turbo.txt *.doc
	find "${D}" -name '*.la' -delete
}
