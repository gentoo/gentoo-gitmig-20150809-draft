# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/devil/devil-1.6.1.ebuild,v 1.9 2004/03/23 19:18:11 mholzer Exp $

IUSE="gif png tiff sdl X opengl jpeg"

inherit libtool

S=${WORKDIR}/DevIL
DESCRIPTION="DevIL image library 1.6.1"
HOMEPAGE="http://www.imagelib.org/"
SRC_URI="mirror://sourceforge/openil/DevIL-${PV}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "

DEPEND="X? ( x11-base/xfree )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	opengl? ( virtual/opengl )"

src_compile() {
	local myconf
	use X && myconf="${myconf} --with-x"
	use gif || myconf="${myconf} --disable-gif"
	use png || myconf="${myconf} --disable-png"
	use sdl || myconf="${myconf} --disable-sdl"
	use jpeg || myconf="${myconf} --disable-jpeg"
	use tiff || myconf="${myconf} --disable-tiff"
	use opengl || myconf="${myconf} --disable-opengl"

	elibtoolize
	econf \
		${myconf} \
		--disable-directx \
		--disable-win32 || die "./configure failed"

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING* CREDITS ChangeLog* INSTALL NEWS* README*
}
