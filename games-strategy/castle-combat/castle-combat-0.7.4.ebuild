# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/castle-combat/castle-combat-0.7.4.ebuild,v 1.2 2004/02/20 07:38:17 mr_bones_ Exp $

inherit games

DESCRIPTION="A clone of the old arcade game Rampart"
HOMEPAGE="http://www.linux-games.com/castle-combat/"
SRC_URI="http://user.cs.tu-berlin.de/~karlb/castle-combat/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	sys-libs/zlib
	media-libs/libpng
	media-libs/libsdl
	media-libs/sdl-net
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	# dist file seems to include a copy of SDL_net.  Take it out so we link
	# against the system copy instead.
	sed -i -e "s/SDL_net//" src/Makefile.in || die "sed src/Makefile.in failed"
}

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	prepgamesdirs
}
