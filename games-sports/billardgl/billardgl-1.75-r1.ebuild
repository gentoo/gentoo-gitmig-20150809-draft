# Copyright 1999-2003 Gentoo Technologies, Inc. and Jordan Armstrong
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/billardgl/billardgl-1.75-r1.ebuild,v 1.1 2003/09/11 12:26:35 vapier Exp $

inherit games

DESCRIPTION="A OpenGL billards game"
SRC_URI="mirror://sourceforge/billardgl/BillardGL-${PV}.tar.gz"
HOMEPAGE="http://www.billardgl.de/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	virtual/glut
	>=sys-apps/sed-4"

S=${WORKDIR}/BillardGL-${PV}/src

src_compile() {
	sed -i \
		-e "s:/usr/share/BillardGL/:${GAMES_DATADIR}/BillardGL/:" Namen.h || \
			die "sed Namen.h failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin BillardGL
	dodir ${GAMES_DATADIR}/BillardGL
	mv lang Texturen ${D}/${GAMES_DATADIR}/BillardGL
	dodoc README
	prepgamesdirs
}
