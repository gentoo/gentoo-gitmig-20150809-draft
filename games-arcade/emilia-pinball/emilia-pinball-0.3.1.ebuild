# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit games

MY_PN=${PN/emilia-/}
MY_P=${MY_PN}-${PV}
DESCRIPTION="SDL OpenGL pinball game"
HOMEPAGE="http://pinball.sourceforge.net/"
SRC_URI="mirror://sourceforge/pinball/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha"

DEPEND="virtual/opengl
	virtual/x11
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer"

S=${WORKDIR}/${MY_P}

src_compile() {
	egamesconf \
		--with-x \
		|| die
	emake -j1 CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dodoc INSTALL README
	make DESTDIR=${D} install || die
	dosym ${GAMES_BINDIR}/pinball ${GAMES_BINDIR}/emilia-pinball
	mv ${D}/${GAMES_PREFIX}/include ${D}/usr/
	dodir /usr/bin
	mv ${D}/${GAMES_BINDIR}/pinball-config ${D}/usr/bin/
	dosed 's:-I${prefix}/include/pinball:-I/usr/include/pinball:' /usr/bin/pinball-config
	prepgamesdirs
}
