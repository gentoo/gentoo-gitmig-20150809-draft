# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.22.ebuild,v 1.4 2002/10/17 13:45:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An amiga emulator"
HOMEPAGE="http://www.freiburg.linux.de/~uae/"
LICENSE="GPL-2"
DEPEND="X? ( virtual/x11 gtk? ( x11-libs/gtk+ ) ) : ( sys-libs/ncurses svga? ( media-libs/svgalib ) )
		sdl? media-libs/libsdl"
SRC_URI="ftp://ftp.freiburg.linux.de/pub/uae/sources/develop/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86"
IUSE="X gtk svga sdl"

src_compile() {
	local myopt
	myopt="";

	if [ `use X` ]; then
		myopt="--with-x --enable-dga --enable-vidmode --with-sdl --with-sdl-sound --with-sdl-gfx"

		use gtk && myopt="$myopt --enable-ui"
		use gtk || myopt="$myopt --disable-ui"
	else
		if [ `use svga` ]; then
			myopt="--with-svgalib";
		else
			myopt="--with-asciiart";
		fi
	fi

	patch -p0 < ${FILESDIR}/uae-patch.diff
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
	        --enable-threads \
                --enable-scsi-device \
		${myopt} || die "./configure failed"
	
	emake || die
}

src_install() {
	dobin uae readdisk
	mv docs/unix/README docs/README.unix
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}
