# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cavezofphear/cavezofphear-0.1.ebuild,v 1.7 2005/01/18 04:04:57 weeve Exp $

inherit games

DESCRIPTION="A boulder dash / digger-like game for console using ncurses"
HOMEPAGE="http://www.x86.no/cavezofphear/"
SRC_URI="http://www.x86.no/cavezofphear/${P/cavezof/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64 ~ppc64 ~sparc"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${P/cavezof/}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's/cd src.*/$(MAKE) -C src/' Makefile \
		|| die "sed Makefile failed"
	sed -i \
		-e 's/^all:.*/all: phear editor/' \
		-e "/^CFLAGS/ s:=.*:= ${CFLAGS}:" src/Makefile \
		|| die "sed src/Makefile failed"
	sed -i \
		-e 's/\.\///' \
		-e 's/editor/phear-editor/g' README-EDITOR \
		|| die "sed README-EDITOR failed"
	sed -i \
		-e "s:\"data/:\"${GAMES_DATADIR}/${PN}/data/:" \
		src/{chk.c,main.c,splash.c} \
		|| die "sed data fix failed"
}

src_install() {
	dogamesbin src/phear || die "dogamesbin failed"
	newgamesbin src/editor phear-editor || die "newgamesbin failed"
	dodir ${GAMES_DATADIR}/${PN}
	cp -r data/ ${D}/${GAMES_DATADIR}/${PN} || die "cp failed"
	dodoc AUTHORS ChangeLog README* TODO
	prepgamesdirs
}
