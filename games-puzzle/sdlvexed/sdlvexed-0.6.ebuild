# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/sdlvexed/sdlvexed-0.6.ebuild,v 1.5 2007/01/24 18:57:30 mr_bones_ Exp $

inherit games

DESCRIPTION="SDL Vexed is a puzzle game written in Perl-SDL. It is a clone of the classic PalmOS game Vexed"
HOMEPAGE="http://freshmeat.net/projects/sdlvexed/"
SRC_URI="http://core.segfault.pl/~krzynio/vexed/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	>=dev-perl/sdl-perl-1.19.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv vexed sdlvexed
	sed -i \
		-e "/PREFIX=/s:\.:${GAMES_DATADIR}/${PN}:" sdlvexed \
		|| die "sed sdlvexed failed"
}

src_install() {
	dogamesbin sdlvexed || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r {gfx,levelpacks} || die "doins failed"
	dodoc CHANGELOG README
	prepgamesdirs
}
