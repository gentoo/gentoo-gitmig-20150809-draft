# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/orbital-eunuchs-sniper/orbital-eunuchs-sniper-1.29.ebuild,v 1.3 2003/12/31 21:16:47 vapier Exp $

inherit games

MY_PN=${PN//-/_}
DESCRIPTION="Snipe terrorists from your orbital base"
HOMEPAGE="http://icculus.org/oes/"
SRC_URI="http://filesingularity.timedoctor.org/${MY_PN}-${PV}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/libsdl-1.2.5-r1
	>=media-libs/sdl-mixer-1.2.5-r1
	>=media-libs/sdl-image-1.2.2"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:datadir="$with_games_dir"::' configure
	cp -rf ${S}{,.orig}
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	sed -i "s:GENTOO_DIR:${GAMES_DATADIR}/${MY_PN}:" src/snipe2d.cpp
}

src_compile() {
	egamesconf --with-games-dir=${GAMES_PREFIX} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodir ${GAMES_LIBDIR}/${PN}
	mv ${D}/${GAMES_DATADIR}/${MY_PN}/snipe2d.* ${D}/${GAMES_LIBDIR}/${PN}/

	dogamesbin ${FILESDIR}/snipe2d
	dosed "s:GENTOO_DIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/snipe2d

	dodoc AUTHORS ChangeLog README TODO readme.txt
	prepgamesdirs
}
