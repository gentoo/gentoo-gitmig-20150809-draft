# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.8 2002/05/30 01:54:49 sandymac Exp

DESCRIPTION="DevIL image library 1.6.1"
HOMEPAGE="http://www.imagelib.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

RDEPEND="X? ( x11-base/xfree )
	gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	sdl? ( media-libs/libsdl )
	opengl? ( virtual/opengl )"


DEPEND="${RDEPEND}"

SRC_URI="mirror://sourceforge/openil/DevIL-${PV}.tar.gz"

S=${WORKDIR}/DevIL

src_compile() {
	local myconf
	use gif || myconf="${myconf} --disable-gif"
	use jpeg || myconf="${myconf} --disable-jpeg"
	use tiff || myconf="${myconf} --disable-tiff"
	use png || myconf="${myconf} --disable-png"
	use opengl || myconf="${myconf} --disable-opengl"
	use sdl || myconf="${myconf} --disable-sdl"
	use X && myconf="${myconf} --with-x"	
	libtoolize --copy --force
	./configure \
		${myconf} \
		--disable-directx \
		--disable-win32 \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING* CREDITS ChangeLog* INSTALL NEWS* README*



}

