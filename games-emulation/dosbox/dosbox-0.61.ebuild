# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-0.61.ebuild,v 1.2 2004/02/04 02:56:03 mr_bones_ Exp $

inherit games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"
SRC_URI="mirror://sourceforge/dosbox/${P}.tar.gz"

KEYWORDS="x86 amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="alsa png opengl"

DEPEND="media-libs/sdl-net
	png? (
		media-libs/libpng
		sys-libs/zlib
	)
	alsa? ( media-libs/alsa-lib )
	opengl? ( virtual/opengl )
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-net"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		`use_enable opengl` \
		`use_enable alsa alsatest` \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS || die "dodoc failed"
	prepgamesdirs
}
