# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ltris/ltris-1.0.10.ebuild,v 1.1 2005/03/18 17:16:51 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="very polished Tetris clone"
HOMEPAGE="http://lgames.sourceforge.net/"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	cp icons/ltris48.xpm icons/${PN}.xpm
}

src_compile() {
	egamesconf --with-highscore-path="${GAMES_STATEDIR}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	doicon icons/${PN}.xpm
	make_desktop_entry ltris ltris ${PN}.xpm
	prepgamesdirs
}
