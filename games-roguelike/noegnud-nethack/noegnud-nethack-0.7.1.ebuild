# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/noegnud-nethack/noegnud-nethack-0.7.1.ebuild,v 1.3 2004/02/20 06:55:42 mr_bones_ Exp $ 

inherit games

NH_DVER=3.4.1
NH_VER=${NH_DVER//.}
DESCRIPTION="an alternate 2D/3D graphical user interface for NetHack"
HOMEPAGE="http://noegnud.sourceforge.net/"
SRC_URI="mirror://sourceforge/noegnud/noegnud-${PV}-src.tar.gz
	mirror://sourceforge/nethack/nethack-${NH_VER}.tgz"

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
	ln -s ${DISTDIR}/nethack-${NH_VER}.tgz noegnud-${PV}/variants/tarballs/nethack-${NH_VER}.tgz
}

src_compile() {
	make nh${NH_VER} PREFIX=${GAMES_PREFIX} || die
}

src_install() {
	make install_nh${NH_VER} PREFIX=${D}/${GAMES_PREFIX} || die

	cd ${D}/${GAMES_BINDIR}
	rm noegnud-nethack-${NH_DVER}
	mv noegnud-${PV}-nethack-${NH_DVER} noegnud-nethack
	dosed "/^HACKDIR/s:=.*:=${GAMES_LIBDIR}/noegnud-${PV}/nethack-${NH_DVER}:" ${GAMES_BINDIR}/noegnud-nethack

	keepdir ${GAMES_LIBDIR}/noegnud-${PV}/nethack-${NH_DVER}/save
	dodir ${GAMES_DATADIR}/noegnud_data
	dosym ${GAMES_DATADIR}/noegnud_data ${GAMES_LIBDIR}/noegnud-${PV}/noegnud_data

	prepgamesdirs
	chmod -R g+w ${D}/${GAMES_LIBDIR}/noegnud-${PV}
}
