# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.22.ebuild,v 1.13 2004/03/24 22:05:50 mr_bones_ Exp $

inherit eutils

DESCRIPTION="An amiga emulator"
HOMEPAGE="http://www.freiburg.linux.de/~uae/"
SRC_URI="ftp://ftp.freiburg.linux.de/pub/uae/sources/develop/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="X gtk svga sdl"

DEPEND="virtual/glibc
	X? (
		virtual/x11
		gtk? ( x11-libs/gtk+ )
	)
	!X? (
		sys-libs/ncurses
		svga? ( media-libs/svgalib )
	)
	sdl? ( media-libs/libsdl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/uae-patch.diff
}

src_compile() {
	local myconf=""

	if use X ; then
		myconf="--with-x --enable-dga --enable-vidmode --with-sdl --with-sdl-sound --with-sdl-gfx"
		myconf="$myconf `use_enable gtk ui`"
	else
		if use svga ; then
			myconf="--with-svgalib";
		else
			myconf="--with-asciiart";
		fi
	fi

	econf \
		--enable-threads \
		--enable-scsi-device \
		${myconf} || die "./configure failed"

	emake -j1 || die "emake failed"
}

src_install() {
	dobin uae readdisk
	cp docs/unix/README docs/README.unix
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}
