# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/pcsx/pcsx-1.5-r1.ebuild,v 1.1 2003/09/09 16:26:50 vapier Exp $

inherit games eutils

S=${WORKDIR}/PcsxSrc-${PV}
DESCRIPTION="Playstation emulator"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://www.pcsx.net/downloads/PcsxSrc-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="opengl"

DEPEND="sys-libs/zlib
	>=sys-apps/sed-4
	app-arch/unzip
	x11-libs/gtk+
	gnome-base/libglade"
RDEPEND="app-emulation/psemu-cdr
	app-emulation/psemu-cdriso
	app-emulation/psemu-padxwin
	app-emulation/psemu-padjoy
	app-emulation/psemu-peopsspu
	|| (
		opengl? ( app-emulation/psemu-gpupetemesagl )
		app-emulation/psemu-peopssoftgpu
	)"

src_unpack() {
	unpack PcsxSrc-${PV}.tgz
	cd ${S}

	edos2unix `find -regex '.*\.[ch]'`

	epatch ${FILESDIR}/${PV}-gentoo.patch
	sed -i \
		-e "s:Plugin/:${GAMES_LIBDIR}/psemu/plugins/:" \
		-e "s:Bios/:${GAMES_LIBDIR}/psemu/bios/:" \
		-e 's:Pcsx.cfg:~/.pcsx/config:' \
		Linux/LnxMain.c \
		|| die "sed LnxMain.c failed"
}

src_compile() {
	cd Linux
	econf || die "econf failed"
	emake OPTIMIZE="${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin Linux/pcsx pcsx.bin
	dogamesbin ${FILESDIR}/pcsx
	insinto ${GAMES_DATADIR}/${PN}
	doins Linux/.pixmaps/*
	dodoc Docs/*
	prepgamesdirs
}
