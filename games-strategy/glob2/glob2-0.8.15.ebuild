# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.8.15.ebuild,v 1.2 2005/05/17 17:00:12 dertobi123 Exp $

inherit games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://www.ysagoon.com/glob2/"
SRC_URI="http://epfl.ysagoon.com/~glob2/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.0
	media-libs/libpng
	media-libs/sdl-net
	media-libs/sdl-image
	media-libs/libvorbis
	>=media-libs/speex-1.1
	=media-libs/freetype-2*
	sys-libs/zlib"

src_compile() {
	#./configure assumes that vorbis will be installed under PREFIX bug #46352
	egamesconf \
		--with-vorbis=/usr \
		--with-speex=/usr \
		--with-speex-includes=/usr/include/speex \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO
	prepgamesdirs
}
