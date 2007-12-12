# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/lmarbles/lmarbles-1.0.7.ebuild,v 1.2 2007/12/12 06:12:29 mr_bones_ Exp $

inherit games

DESCRIPTION="puzzle game inspired by Atomix and written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LMarbles"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

src_unpack() {
	unpack ${A}
	cd "${S}"
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
