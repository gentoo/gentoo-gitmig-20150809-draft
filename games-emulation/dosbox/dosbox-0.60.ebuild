# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.60.ebuild,v 1.2 2003/10/18 07:28:56 mr_bones_ Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

IUSE="alsa ncurses png"

DEPEND="png? ( media-libs/libpng sys-libs/zlib )
	alsa? ( media-libs/alsa-lib )
	media-libs/sdl-net
	>=media-libs/libsdl-1.2.0"

src_compile() {
	egamesconf \
		`use_enable alsa alsatest` || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS
	prepgamesdirs
}
