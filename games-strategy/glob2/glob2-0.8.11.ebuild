# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glob2/glob2-0.8.11.ebuild,v 1.1 2005/01/30 03:08:13 jnc Exp $

inherit games

DESCRIPTION="Real Time Strategy (RTS) game involving a brave army of globs"
HOMEPAGE="http://www.ysagoon.com/glob2/"
SRC_URI="http://epfl.ysagoon.com/~glob2/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	virtual/opengl
	>=media-libs/libsdl-1.2.0
	media-libs/libpng
	media-libs/sdl-net
	media-libs/sdl-image
	media-libs/libvorbis
	>=media-libs/speex-1.1
	=media-libs/freetype-2*
	sys-libs/zlib"
RDEPEND="${DEPEND}
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5"

src_unpack() {
	unpack ${P}.tar.gz || die
	epatch ${FILESDIR}/${P}-*.patch
}

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal
	automake
	autoconf

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
