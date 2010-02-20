# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qrencode/qrencode-3.1.1.ebuild,v 1.1 2010/02/20 20:47:27 joker Exp $

DESCRIPTION="C library for encoding data in a QR Code symbol"
HOMEPAGE="http://megaui.net/fukuchi/works/qrencode/index.en.html"
SRC_URI="http://megaui.net/fukuchi/works/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libpng"

RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README TODO NEWS ChangeLog
}
