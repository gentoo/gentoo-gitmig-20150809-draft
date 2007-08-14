# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/devil/devil-1.6.7-r2.ebuild,v 1.1 2007/08/14 17:20:57 nyhm Exp $

inherit autotools eutils

DESCRIPTION="DevIL image library"
HOMEPAGE="http://openil.sourceforge.net/"
SRC_URI="mirror://sourceforge/openil/DevIL-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="gif jpeg mng png tiff xpm allegro opengl sdl X"

RDEPEND="gif? ( media-libs/giflib )
	jpeg? ( media-libs/jpeg )
	mng? ( media-libs/libmng )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
	xpm? ( x11-libs/libXpm )
	allegro? ( media-libs/allegro )
	opengl? ( virtual/glu )
	sdl? ( media-libs/libsdl )
	X? ( x11-libs/libXext )"
DEPEND="${RDEPEND}
	X? ( x11-proto/xextproto )"

S=${WORKDIR}/DevIL-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-png-types.patch \
		"${FILESDIR}"/${P}-sdl-checks.patch \
		"${FILESDIR}"/${P}-gcc42.patch
	sed -i \
		-e 's/<il/<IL/' \
		include/IL/il_wrap.h \
		|| die "sed failed"
	eautoconf
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		$(use_enable gif) \
		$(use_enable jpeg) \
		$(use_enable mng) \
		$(use_enable png) \
		$(use_enable tiff) \
		$(use_enable xpm) \
		$(use_enable allegro) \
		$(use_enable opengl) \
		$(use_enable sdl) \
		$(use_with X x) \
		--disable-directx \
		--disable-win32 \
		--enable-static \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS CREDITS ChangeLog* NEWS* README*
}
