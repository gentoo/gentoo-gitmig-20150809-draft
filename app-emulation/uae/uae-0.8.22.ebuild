# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uae/uae-0.8.22.ebuild,v 1.8 2003/02/13 07:16:46 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An amiga emulator"
HOMEPAGE="http://www.freiburg.linux.de/~uae/"
LICENSE="GPL-2"
DEPEND="X? ( virtual/x11 gtk? ( x11-libs/gtk+ ) ) : ( sys-libs/ncurses svga? ( media-libs/svgalib ) )
		sdl? media-libs/libsdl"
SRC_URI="ftp://ftp.freiburg.linux.de/pub/uae/sources/develop/${P}.tar.gz"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X gtk svga sdl"

src_compile() {
	local myconf
	myconf="";

	if [ `use X` ]; then
		myconf="--with-x --enable-dga --enable-vidmode --with-sdl --with-sdl-sound --with-sdl-gfx"

		use gtk && myconf="$myconf --enable-ui"
		use gtk || myconf="$myconf --disable-ui"
	else
		if [ `use svga` ]; then
			myconf="--with-svgalib";
		else
			myconf="--with-asciiart";
		fi
	fi

	patch -p0 < ${FILESDIR}/uae-patch.diff
	econf \
		--enable-threads \
		--enable-scsi-device \
		${myconf} || die "./configure failed"

	make || die
}

src_install() {
	dobin uae readdisk
	mv docs/unix/README docs/README.unix
	dodoc docs/*

	insinto /usr/share/uae/amiga-tools
	doins amiga/{*hack,trans*,uae*}
}
