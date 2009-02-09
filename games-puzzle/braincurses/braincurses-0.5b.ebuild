# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/braincurses/braincurses-0.5b.ebuild,v 1.7 2009/02/09 15:26:40 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="An ncurses-based mastermind clone"
HOMEPAGE="http://freshmeat.net/projects/braincurses/"
SRC_URI="mirror://sourceforge/braincurses/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	dogamesbin braincurses || die "dogamesbin failed"
	dodoc README THANKS Changelog
	prepgamesdirs
}
