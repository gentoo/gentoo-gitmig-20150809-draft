# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-slashem/noegnud-slashem-0.7.1.ebuild,v 1.2 2003/09/10 05:16:14 vapier Exp $

inherit games

SE_DVER=0.0.6E4F8
SE_VER=006e4f8
DESCRIPTION="an alternate 2D/3D graphical user interface for SLASH'EM"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}-src.tar.gz
	mirror://sourceforge/slashem/se${SE_VER}.tar.gz"

LICENSE="nethack"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/libsdl
	dev-util/yacc"
RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	virtual/opengl
	games-roguelike/noegnud-data"

S=${WORKDIR}/noegnud-${PV}/variants

src_unpack() {
	unpack noegnud-${PV}-src.tar.gz
	ln -s ${DISTDIR}/se${SE_VER}.tgz noegnud-${PV}/variants/tarballs/se${SE_VER}.tgz
}

src_compile() {
	make se${SE_VER} PREFIX=${GAMES_PREFIX} || die
}

src_install() {
	make install_se${SE_VER} PREFIX=${D}/${GAMES_PREFIX} || die

	cd ${D}/${GAMES_BINDIR}
	rm noegnud-slashem-${SE_DVER}
	mv noegnud-${PV}-slashem-${SE_DVER} noegnud-slashem
	dosed "/^HACKDIR/s:=.*:=${GAMES_LIBDIR}/noegnud-${PV}/slashem-${SE_DVER}:" ${GAMES_BINDIR}/noegnud-slashem

	keepdir ${GAMES_LIBDIR}/noegnud-${PV}/slashem-${SE_DVER}/save
	dodir ${GAMES_DATADIR}/noegnud_data
	dosym ${GAMES_DATADIR}/noegnud_data ${GAMES_LIBDIR}/noegnud-${PV}/noegnud_data

	prepgamesdirs
	chmod -R g+w ${D}/${GAMES_LIBDIR}/noegnud-${PV}
}
