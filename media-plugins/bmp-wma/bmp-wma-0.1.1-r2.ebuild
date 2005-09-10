# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-wma/bmp-wma-0.1.1-r2.ebuild,v 1.1 2005/09/10 01:25:27 chainsaw Exp $

IUSE="wma123"

inherit flag-o-matic

DESCRIPTION="BMP plugin to play windows media audio format files"
HOMEPAGE="http://bmp-plugins.berlios.de/bmp-wma.html"
SRC_URI="http://www.nixp.ru/pub/files/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86 ~amd64"

DEPEND="media-sound/beep-media-player"

src_compile() {
	append-flags -fPIC
	econf \
		`use_enable x86` \
		`use_enable wma123` \
		--disable-static || die
	emake
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README
}
