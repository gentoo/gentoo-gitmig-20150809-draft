# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games

S="${WORKDIR}/${PN}_linux/gens"
DESCRIPTION="A Sega Genesis/CD/32X emulator"
SRC_URI="mirror://sourceforge/gens/Gens212a1SrcL.zip"
HOMEPAGE="http://gens.consolemul.com/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2
	app-arch/unzip
	>=dev-lang/nasm-0.98
	>=sys-apps/sed-4
	>=x11-libs/gtk+-2.0*"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:\./resource:${GAMES_DATADIR}/${P}:" g_ddraw_dummy.cpp || \
			die "sed g_ddraw_dummy.cpp failed"

	sed -i \
		-e "s:\./resource:${GAMES_DATADIR}/${P}:" g_main_dummy.cpp || \
			die "sed g_main_dummy.cpp failed"
}

src_install () {
	dogamesbin gens

	insinto ${GAMES_DATADIR}/${P}
	doins resource/*

	# Install documentation.
	dodoc ../README

	prepgamesdirs
}
