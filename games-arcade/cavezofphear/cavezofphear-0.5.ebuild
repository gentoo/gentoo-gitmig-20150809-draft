# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cavezofphear/cavezofphear-0.5.ebuild,v 1.2 2007/04/09 21:53:38 welp Exp $

inherit toolchain-funcs games

DESCRIPTION="A boulder dash / digger-like game for console using ncurses"
HOMEPAGE="http://www.x86.no/cavezofphear/"
SRC_URI="http://www.x86.no/${PN}/${P/cavezof}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${P/cavezof/}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/cd src.*/$(MAKE) -C src phear/' Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e "/^CC/ s:gcc:$(tc-getCC):" \
		-e "/^CFLAGS/ s:=.*:= ${CFLAGS}:" \
		-e "/^LDFLAGS/ s:$: ${LDFLAGS}:" \
		src/Makefile \
		|| die "sed src/Makefile failed"
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
