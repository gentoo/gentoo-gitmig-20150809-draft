# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/devil/devil-1.6.6.ebuild,v 1.4 2004/04/03 23:45:56 spyderous Exp $

inherit libtool

DESCRIPTION="DevIL image library"
HOMEPAGE="http://www.imagelib.org/"
SRC_URI="mirror://sourceforge/openil/DevIL-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64"
IUSE="X gif png sdl jpeg tiff opengl"

RDEPEND="X? ( virtual/x11 )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	opengl? ( virtual/opengl )"

S=${WORKDIR}/DevIL

src_compile() {
	elibtoolize
	econf \
		`use_with X x` \
		`use_enable gif` \
		`use_enable png` \
		`use_enable sdl` \
		`use_enable jpeg` \
		`use_enable tiff` \
		`use_enable opengl` \
		--disable-directx \
		--disable-win32 || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS BUGS CREDITS ChangeLog* INSTALL NEWS* README*
}
