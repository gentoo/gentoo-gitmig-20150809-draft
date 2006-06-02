# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/billardgl/billardgl-1.75-r1.ebuild,v 1.7 2006/06/02 07:48:29 mr_bones_ Exp $

inherit games

DESCRIPTION="A OpenGL billards game"
HOMEPAGE="http://www.billardgl.de/"
SRC_URI="mirror://sourceforge/billardgl/BillardGL-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86 ppc"
SLOT="0"
IUSE=""

DEPEND="|| ( ( x11-libs/libXi
				x11-libs/libXmu )
			virtual/x11 )
	virtual/opengl
	virtual/glu
	virtual/glut"

S=${WORKDIR}/BillardGL-${PV}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/usr/share/BillardGL/:${GAMES_DATADIR}/BillardGL/:" Namen.h \
		|| die "sed failed"
	sed -i \
		-e "/^CFLAGS/ s:-pipe -Wall -W:${CFLAGS}:" \
		-e "/^CXXFLAGS/ s:-pipe -Wall -W:${CXXFLAGS}:" Makefile \
		|| die "sed failed"
}

src_install() {
	dogamesbin BillardGL || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/BillardGL"
	cp -r lang/ Texturen/ "${D}/${GAMES_DATADIR}/BillardGL" || die "cp failed"
	dodoc README
	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry ${PN} "BillardGL"
	prepgamesdirs
}
