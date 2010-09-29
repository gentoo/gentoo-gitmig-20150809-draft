# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode/qrencode-3.1.1.ebuild,v 1.5 2010/09/29 15:13:39 ranger Exp $

EAPI=2
inherit autotools

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="http://megaui.net/fukuchi/works/qrencode/index.en.html"
SRC_URI="http://megaui.net/fukuchi/works/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:libpng12:libpng:' \
		configure.ac || die

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README TODO
}
