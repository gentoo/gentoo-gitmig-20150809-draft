# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.12.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games

S="${WORKDIR}/${PN}_linux/gens"
DESCRIPTION="A Sega Genesis/CD/32X emulator"
SRC_URI="mirror://sourceforge/gens/Gens212a1SrcL.zip"
HOMEPAGE="http://gens.consolemul.com/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=x11-libs/gtk+-2.0*"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	app-arch/unzip
	>=dev-lang/nasm-0.98"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:\./resource:${GAMES_DATADIR}/${P}:" g_ddraw_dummy.cpp || \
			die "sed g_ddraw_dummy.cpp failed"

	sed -i \
		-e "s:\./resource:${GAMES_DATADIR}/${P}:" g_main_dummy.cpp || \
			die "sed g_main_dummy.cpp failed"

	# Starting with nasm-0.98.37, -O3 is no longer an alias for -O15
	# the nasm devs recommend either not using -O or using -O999 since
	# nasm will stop after no more optimizations are possible.
	#
	# This fix is for the asm files in gens that need more than 3 passes
	# and fail with the new releases of nasm.
	sed -i \
		-e '/^NASMFLAGS=/ s:-O3:-O999:' Makefile
}

src_install () {
	dogamesbin gens

	insinto ${GAMES_DATADIR}/${P}
	doins resource/*

	# Install documentation.
	dodoc ../README

	prepgamesdirs
}
