# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/pcsx/pcsx-1.5-r1.ebuild,v 1.10 2007/02/24 00:53:40 nyhm Exp $

inherit eutils games

DESCRIPTION="PlayStation emulator"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://www.pcsx.net/downloads/PcsxSrc-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE="opengl"

DEPEND=">=x11-libs/gtk+-2
	gnome-base/libglade"
RDEPEND="${DEPEND}
	games-emulation/psemu-cdr
	games-emulation/psemu-cdriso
	games-emulation/psemu-padxwin
	games-emulation/psemu-padjoy
	games-emulation/psemu-peopsspu
	opengl? ( games-emulation/psemu-gpupetemesagl )
	!opengl? ( games-emulation/psemu-peopssoftgpu )"

S=${WORKDIR}/PcsxSrc-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	edos2unix $(find -regex '.*\.[ch]')

	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc41.patch
	sed -i \
		-e "s:Plugin/:${GAMES_LIBDIR}/psemu/plugins/:" \
		-e "s:Bios/:${GAMES_LIBDIR}/psemu/bios/:" \
		-e 's:Pcsx.cfg:~/.pcsx/config:' \
		Linux/LnxMain.c \
		|| die "sed LnxMain.c failed"
	sed \
		-e "s:GAMES_DATADIR:${GAMES_DATADIR}:" \
		-e "s:GAMES_LIBDIR:${GAMES_LIBDIR}:" \
		-e "s:GAMES_BINDIR:${GAMES_BINDIR}:" \
		"${FILESDIR}"/pcsx > "${T}"/pcsx \
		|| die "sed failed"
}

src_compile() {
	cd Linux
	egamesconf || die
	emake OPTIMIZE="${CFLAGS}" STRIP=true || die "emake failed"
}

src_install() {
	newgamesbin Linux/pcsx pcsx.bin || die "newgamesbin failed"
	dogamesbin "${T}"/pcsx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins Linux/.pixmaps/* || die "doins failed"
	dodoc Docs/*
	prepgamesdirs
}
