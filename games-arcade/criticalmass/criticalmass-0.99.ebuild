# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/criticalmass/criticalmass-0.99.ebuild,v 1.5 2004/11/01 11:29:12 josejx Exp $

inherit eutils games

DESCRIPTION="SDL/OpenGL space shoot'em up game"
HOMEPAGE="http://criticalmass.sourceforge.net/"
SRC_URI="mirror://sourceforge/criticalmass/CriticalMass-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND="media-libs/sdl-mixer
	media-libs/sdl-image
	virtual/opengl"

S=${WORKDIR}/CriticalMass-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc-3.4.patch
}

src_compile() {
	egamesconf || die
	sed -i \
		-e "/^CXXFLAGS =.*$/s:$: ${CXXFLAGS}:" \
		{game,tinyxml,tools,utils}/Makefile \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dohtml Readme.html
	dodoc TODO
	prepgamesdirs
}
