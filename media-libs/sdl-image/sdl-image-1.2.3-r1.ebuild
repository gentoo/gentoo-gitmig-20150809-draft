# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl-image/sdl-image-1.2.3-r1.ebuild,v 1.4 2004/08/12 00:36:08 mr_bones_ Exp $

inherit gnuconfig


MY_P="${P/sdl-/SDL_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="image file loading library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_image/index.html"
SRC_URI="http://www.libsdl.org/projects/SDL_image/release/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ppc64"
IUSE="gif jpeg tiff png"

DEPEND="sys-libs/zlib
	>=media-libs/libsdl-1.2.4
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b )
	tiff? ( media-libs/tiff )
	gif? ( media-libs/giflib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable gif) \
		$(use_enable jpeg jpg) \
		$(use_enable tiff tif) \
		$(use_enable png) \
		$(use_enable png pnm) \
		--enable-bmp \
		--enable-lbm \
		--enable-pcx \
		--enable-tga \
		--enable-xcf \
		--enable-xpm \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	into /usr
	dobin .libs/showimage
	dodoc CHANGES README
}
