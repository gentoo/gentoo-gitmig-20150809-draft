# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-rootvis/bmp-rootvis-0.0.1.ebuild,v 1.3 2005/07/25 11:48:51 dholm Exp $

IUSE=""

DESCRIPTION="BMP plugin to run the a vislization on the root window"
HOMEPAGE="http://bmp-plugins.berlios.de/bmp-rootvis.html"
SRC_URI="http://download.berlios.de/bmp-plugins/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"

DEPEND="media-sound/beep-media-player"

src_unpack() {
	unpack ${A}
}

src_install () {
	make DESTDIR=${D} install || die
}
