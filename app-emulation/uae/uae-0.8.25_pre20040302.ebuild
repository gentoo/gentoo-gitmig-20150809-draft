# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.25_pre20040302.ebuild,v 1.6 2004/03/24 22:05:50 mr_bones_ Exp $

inherit flag-o-matic

MY_PV="0.8.25-20040302"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="The Umiquious Amiga Emulator"
HOMEPAGE="http://www.rcdrummond.net/uae/"
SRC_URI="http://www.rcdrummond.net/uae/uae-${MY_PV}/uae-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="X gtk sdl ncurses svga"

DEPEND="virtual/glibc
	X? (
		virtual/x11
		gtk? ( x11-libs/gtk+ )
	)
	!X? (
		ncurses? ( sys-libs/ncurses )
		svga? ( media-libs/svgalib )
	)
	sdl? ( media-libs/libsdl )
	app-cdr/cdrtools
	games-emulation/caps"

src_compile() {
	# -O3 breaks compilation, GCC will eat all your RAM + Swap and die
	replace-flags "-O3" "-O2"
	use sdl && myconf="--with-sdl-sound --with-sdl-gfx"

	cp ${FILESDIR}/split_cpuemu.pl ${S}/src
	chmod +x ${S}/src/split_cpuemu.pl

	econf ${myconf} \
		--enable-threads \
		--enable-scsi-device \
		--with-libscg-includedir=/usr/include/scsilib \
		|| die "./configure failed"

	cd ${S}/src

	sed -ir 's#cpuemu_6.\([a-z]*\)#cpuemu_6.\1 cpuemu_7.\1#g' Makefile
	sed -ir 's#cpuemu_nf_6.\([a-z]*\)#cpuemu_nf_6.\1 cpuemu_nf_7.\1#g' Makefile
	sed -ir 's#\(./tools/build68k <../src/table68k >cpudefs.c\)#\1\n	./split_cpuemu.pl; mv cpuemu_6.t cpuemu_6.c#' Makefile

	cd ${S}

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
