# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-songchange/bmp-songchange-0.0.2.ebuild,v 1.3 2005/08/23 22:27:50 chainsaw Exp $

IUSE=""

DESCRIPTION="Song Changing plugin for Beep Media Player"
HOMEPAGE="http://developer.berlios.de/projects/bmp-plugins/"
SRC_URI="http://download.berlios.de/bmp-plugins/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~amd64 x86"

DEPEND="media-sound/beep-media-player"

src_compile() {
	econf '--disable-static' || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
