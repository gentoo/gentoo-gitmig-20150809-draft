# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/sdlvexed/sdlvexed-0.5.ebuild,v 1.2 2004/06/08 20:39:42 dholm Exp $

inherit games

DESCRIPTION="SDL Vexed is a puzzle game written in Perl-SDL. It is a clone of the classic PalmOS game Vexed"
HOMEPAGE="http://freshmeat.net/projects/sdlvexed/"
SRC_URI="http://apcoh.org/~krzynio/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/glibc
	>=dev-lang/perl-5.6.1
	>=media-libs/sdl-mixer-1.2.3
	>=dev-perl/sdl-perl-1.19.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/vexed"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv vexed.pl sdlvexed
	sed -i \
		-e "/PREFIX=/s:\.:${GAMES_DATADIR}/${PN}:" sdlvexed \
		|| die "sed sdlvexed failed"
}


src_install() {
	dogamesbin sdlvexed || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R {gfx,levelpacks} "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc README
	prepgamesdirs
}
