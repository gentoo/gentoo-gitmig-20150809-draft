# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cavezofphear/cavezofphear-0.5.ebuild,v 1.3 2009/01/30 16:35:51 tupone Exp $

EAPI=2
inherit toolchain-funcs eutils games

DESCRIPTION="A boulder dash / digger-like game for console using ncurses"
HOMEPAGE="http://www.x86.no/cavezofphear/"
SRC_URI="http://www.x86.no/${PN}/${P/cavezof}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${P/cavezof/}

src_prepare() {
	export CC=$(tc-getCC)
	sed -i \
		-e 's/cd src.*/$(MAKE) -C src phear/' Makefile \
		|| die "sed Makefile failed"
	epatch "${FILESDIR}"/${P}-gentoo.patch
	sed -i \
		-e "s:get_data_dir(.):\"${GAMES_DATADIR}/${PN}/\":" \
		src/{chk.c,main.c,gplot.c} \
		|| die "sed data fix failed"
}

src_install() {
	dogamesbin src/phear || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data/* || die "doins failed"
	dodoc ChangeLog README* TODO
	prepgamesdirs
}
