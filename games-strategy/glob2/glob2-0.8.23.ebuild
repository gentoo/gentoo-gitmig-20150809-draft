# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.8.23.ebuild,v 1.1 2007/04/19 08:05:07 mr_bones_ Exp $

inherit games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://globulation2.org/"
SRC_URI="http://dl.sv.nongnu.org/releases/glob2/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="virtual/opengl
	dev-libs/boost
	>=media-libs/libsdl-1.2.0
	media-libs/libpng
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/libvorbis
	>=media-libs/speex-1.1
	=media-libs/freetype-2*
	sys-libs/zlib"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^glob2linkdir/s:\$(datadir):/usr/share:" \
		data/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e "/^glob2icondir/s:\$(datadir):/usr/share:" \
		data/icons/Makefile.in \
		|| die "sed failed"
}

src_compile() {
	#./configure assumes that vorbis will be installed under PREFIX bug #46352
	egamesconf \
		--disable-dependency-tracking \
		--with-vorbis=/usr \
		--with-speex=/usr \
		--with-speex-includes=/usr/include/speex \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
	prepgamesdirs
}
