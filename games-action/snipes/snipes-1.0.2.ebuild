# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/snipes/snipes-1.0.2.ebuild,v 1.1 2008/09/04 21:05:17 nyhm Exp $

inherit toolchain-funcs games

DESCRIPTION="2D scrolling shooter, resembles the old DOS game of same name"
HOMEPAGE="http://geocities.com/fnorddaemon/"
SRC_URI="http://geocities.com/fnorddaemon/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin snipes || die "dogamesbin failed"
	doman snipes.6
	dodoc ChangeLog
	prepgamesdirs
}
