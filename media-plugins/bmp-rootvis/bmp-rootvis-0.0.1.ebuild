# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-rootvis/bmp-rootvis-0.0.1.ebuild,v 1.2 2004/12/05 19:35:11 chainsaw Exp $

IUSE=""

DESCRIPTION="BMP plugin to run the a vislization on the root window"
HOMEPAGE="http://bmp-plugins.berlios.de/bmp-rootvis.html"
SRC_URI="http://download.berlios.de/bmp-plugins/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-sound/beep-media-player"

src_unpack() {
	unpack ${A}
}

src_install () {
	make DESTDIR=${D} install || die
}
