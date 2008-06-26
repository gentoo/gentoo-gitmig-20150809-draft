# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/textmaze/textmaze-1.2.ebuild,v 1.3 2008/06/26 08:44:33 opfer Exp $

inherit games

MY_P=${PN}_v${PV}

DESCRIPTION="An ncurses-based maze solving game written in Perl"
HOMEPAGE="http://freshmeat.net/projects/textmaze/"
SRC_URI="http://www.robobunny.com/projects/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-perl/Curses"

S="${WORKDIR}/TextMaze"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s#/usr/local/bin/perl#/usr/bin/perl#" \
		textmaze \
		|| die "sed failed"
}

src_install() {
	dogamesbin textmaze || die "dogamesbin failed"
	dodoc CHANGES README
	prepgamesdirs
}
