# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-wma/bmp-wma-0.1.1.ebuild,v 1.1 2004/12/21 22:17:11 chainsaw Exp $

IUSE="wma123"

DESCRIPTION="BMP plugin to play windows media audio format files"
HOMEPAGE="http://bmp-plugins.berlios.de/bmp-wma.html"
SRC_URI="http://bmp-plugins.berlios.de/download/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/beep-media-player"

src_compile() {
	econf \
		`use_enable x86` \
		`use_enable wma123`
	emake
}

src_install () {
	make DESTDIR=${D} install || die
}
