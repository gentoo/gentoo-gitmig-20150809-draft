# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.58.ebuild,v 1.4 2004/02/11 09:17:26 mr_bones_ Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.0
	sys-libs/zlib"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
