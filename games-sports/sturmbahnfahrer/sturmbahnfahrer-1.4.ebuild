# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/sturmbahnfahrer/sturmbahnfahrer-1.4.ebuild,v 1.3 2007/09/01 12:18:02 josejx Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Simulated obstacle course for automobiles"
HOMEPAGE="http://www.sturmbahnfahrer.com/"
SRC_URI="http://www.stolk.org/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	virtual/glut
	>=dev-games/ode-0.6
	>=media-libs/plib-1.8.4
	media-libs/alsa-lib"

S=${WORKDIR}/${P}/src-${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "/dirprefix \?=/s:=.*: = \"${GAMES_DATADIR}/${PN}\";:" main.cxx \
		|| die "sed failed"

	sed -i \
		-e "s:g++:$(tc-getCXX):" \
		-e "/OBJS=/i CXXFLAGS=${CXXFLAGS} -I../src-common" \
		-e "/OBJS=/i LFLAGS=${LDFLAGS}" \
		-e 's:$(ODEPREFIX)/lib/libode.a:-lode:' \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r images/ models/ sounds/ || die "doins failed"
	dodoc JOYSTICKS README TODO
	make_desktop_entry ${PN} Sturmbahnfahrer
	prepgamesdirs
}
