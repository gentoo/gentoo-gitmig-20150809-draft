# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gunocide2ex/gunocide2ex-1.0.ebuild,v 1.1 2003/11/14 17:12:05 vapier Exp $

inherit games eutils gcc

DESCRIPTION="fast-paced 2D shoot'em'up"
HOMEPAGE="http://www.polyfrag.com/content/product_gunocide.html"
SRC_URI="mirror://sourceforge/g2ex/g2ex-setup.run"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-mixer"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
	sed -i "s:-g:${CFLAGS}:" makefile
	mkdir binary
	epatch ${FILESDIR}/${PV}-gcc3.patch
	edos2unix config.cfg
	sed -i \
		-e "s:/usr/local/games/gunocide2ex/config\.cfg:${GAMES_SYSCONFDIR}/${PN}.cfg:" \
		-e "s:/usr/local/games/gunocide2ex/hscore\.dat:${GAMES_STATEDIR}/${PN}-hscore.dat:" \
		src/*.{h,cpp}
	sed -i \
		-e "s:/usr/local/games:${GAMES_DATADIR}:" \
		src/*.{h,cpp} `find gfx -name '*.txt'`
}

src_compile() {
	cd src
	local cc=$(gcc-getCXX)
	for f in *.cpp ; do
		echo "${cc} ${CFLAGS} ${f}"
		${cc} ${cflags} -c ${f} || die "couldnt compile ${f}"
	done
	${cc} -o ${PN} *.o -lpthread -lSDL -lSDL_ttf -lSDL_mixer || die "couldnt produce binary"
}

src_install() {
	dogamesbin src/${PN}
	dosym ${PN} ${GAMES_BINDIR}/g2ex
	dodir ${GAMES_DATADIR}/${PN}
	cp -r gfx sfx lvl credits arial.ttf ${D}/${GAMES_DATADIR}/${PN}/
	insinto ${GAMES_SYSCONFDIR}
	newins config.cfg ${PN}.cfg
	insinto ${GAMES_STATEDIR}
	newins hscore.dat ${PN}-hscore.dat
	dodoc README history doc/MANUAL_DE
	dohtml doc/manual_de.html
	prepgamesdirs
}
