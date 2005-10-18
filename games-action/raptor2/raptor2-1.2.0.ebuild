# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/raptor2/raptor2-1.2.0.ebuild,v 1.1 2005/10/18 03:03:00 vapier Exp $

inherit eutils games

MY_P="raptor-${PV}"
DESCRIPTION="space shoot-em-up game"
HOMEPAGE="http://raptorv2.sourceforge.net/"
SRC_URI="mirror://sourceforge/raptorv2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/aldumb-0.9.2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/AM_CXXFLAGS/s:-O3 -s::' \
		src/Makefile.in || die
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/defs.cpp \
		|| die "sed src/raptor.cpp failed"
}

src_install() {
	dogamesbin src/raptor || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins data/* || die "doins failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
