# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/devil/devil-1.6.6-r1.ebuild,v 1.1 2004/03/19 02:20:54 vapier Exp $

inherit eutils libtool

DESCRIPTION="DevIL image library"
HOMEPAGE="http://www.imagelib.org/"
SRC_URI="mirror://sourceforge/openil/DevIL-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="X gif png sdl jpeg tiff opengl"

RDEPEND="X? ( x11-base/xfree )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	sdl? ( media-libs/libsdl )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	opengl? ( virtual/opengl )"

S=${WORKDIR}/DevIL

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:_vsnprintf:vsnprintf:' src-IL/src/il_tiff.c || die
	epatch ${FILESDIR}/${PV}-configure.in.patch
	autoconf || die
	elibtoolize || die
}

src_compile() {
	econf \
		`use_with X x` \
		`use_enable gif` \
		`use_enable png` \
		`use_enable sdl` \
		`use_enable jpeg` \
		`use_enable tiff` \
		`use_enable opengl` \
		--disable-directx \
		--disable-win32 \
		|| die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS BUGS CREDITS ChangeLog* INSTALL NEWS* README*
}
