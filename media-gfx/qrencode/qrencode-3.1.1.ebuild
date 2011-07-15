# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode/qrencode-3.1.1.ebuild,v 1.7 2011/07/15 15:44:14 jlec Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="http://megaui.net/fukuchi/works/qrencode/index.en.html"
SRC_URI="http://megaui.net/fukuchi/works/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="
	dev-python/imaging
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-pngregenfix.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
