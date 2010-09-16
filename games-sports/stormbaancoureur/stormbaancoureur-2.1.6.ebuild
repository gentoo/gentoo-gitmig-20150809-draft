# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/stormbaancoureur/stormbaancoureur-2.1.6.ebuild,v 1.3 2010/09/16 17:52:37 scarabeus Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Simulated obstacle course for automobiles"
HOMEPAGE="http://www.stolk.org/stormbaancoureur/"
SRC_URI="http://www.stolk.org/stormbaancoureur/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut
	>=dev-games/ode-0.8
	>=media-libs/plib-1.8.4
	media-libs/alsa-lib"

S=${WORKDIR}/${P}/src-${PN}

src_prepare() {
	sed -i \
		-e "/dirprefix \?=\"/s:=.*: = \"${GAMES_DATADIR}/${PN}\";:" main.cxx \
		|| die "sed failed"

	sed -i \
		-e "/^CXX=/d" \
		-e '/Wall/d' \
		-e "/^CXXFLAGS/ s%=%= ${CXXFLAGS} %" \
		-e '/DGAMEVERSION/s:\\::' \
		-e '/^LFLAGS=/s:=:= $(LDFLAGS) :' \
		-e 's:$(ODEPREFIX)/$(LIBDIRNAME)/libode.a:-lode:' \
		Makefile || die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r images/ models/ sounds/ shaders/ || die "doins failed"
	dodoc JOYSTICKS README TODO
	make_desktop_entry ${PN} "Stormbaan Coureur"
	prepgamesdirs
}
