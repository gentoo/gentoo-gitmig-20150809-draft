# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/m17n-lib/m17n-lib-1.0.2.ebuild,v 1.3 2004/06/24 23:27:37 agriffis Exp $

inherit flag-o-matic libtool

DESCRIPTION="Multilingual Library for Unix/Linux"
HOMEPAGE="http://www.m17n.org/m17n-lib/"
SRC_URI="http://www.m17n.org/m17n-lib/download/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/fribidi
	>=media-libs/freetype-2.1
	dev-libs/libotf
	dev-db/m17n-db"

src_compile() {

	elibtoolize
	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
