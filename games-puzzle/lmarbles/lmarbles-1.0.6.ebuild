# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lmarbles/lmarbles-1.0.6.ebuild,v 1.2 2004/06/09 02:15:15 mr_bones_ Exp $

inherit games

DESCRIPTION="puzzle game inspired by Atomix and written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LMarbles"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/^inst_dir/s:/games::' \
		-e "/^prf_dir/s:/var/lib/games:${GAMES_STATEDIR}:" configure \
		|| die "sed configure failed"
	sed -i \
		-e '/c_pth, strlen/s:strlen:sizeof:' src/cfg.c \
		|| die "sed src/cfg.c failed"
	sed -i \
		-e 's:/marbles.prfs:/lmarbles.prfs:' \
		src/Makefile.in src/lmarbles.6 \
		|| die "sed marbles/lmarbles failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
