# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.60.ebuild,v 1.1 2003/10/16 22:34:23 mr_bones_ Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

IUSE="alsa ncurses png"

DEPEND="ncurses? ( sys-libs/ncurses )
	png? ( media-libs/libpng sys-libs/zlib )
	alsa? ( media-libs/alsa-lib )
	media-libs/sdl-net
	>=media-libs/libsdl-1.2.0"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
