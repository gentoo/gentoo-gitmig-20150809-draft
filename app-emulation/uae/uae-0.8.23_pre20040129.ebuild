# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.23_pre20040129.ebuild,v 1.2 2004/02/09 10:55:02 dholm Exp $

MY_PV="0.8.23-20040129"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="An amiga emulator"
HOMEPAGE="http://www.rcdrummond.net/uae/"
SRC_URI="http://www.rcdrummond.net/uae/uae-${MY_PV}/uae-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X gtk sdl"

DEPEND="X? ( virtual/x11 gtk? x11-libs/gtk+ ) :
	( ncurses? sys-libs/ncurses svga? media-libs/svgalib )
	sdl? media-libs/libsdl"

src_compile() {
	ewarn "Compiling the CPU-core requires a substantial amount of RAM."
	ewarn "Make sure that you have at least 512MB of RAM+SWAP available."

	econf || die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	cp docs/unix/README docs/README.unix
	dodoc docs/COMPATIBILITY docs/CREDITS docs/FAQ docs/NEWS \
		docs/README docs/README.PROGRAMMERS docs/README.unix \
		docs/translated/*

	emake install DESTDIR=${D}

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*,*.library}
}
