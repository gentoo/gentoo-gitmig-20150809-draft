# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vflib/vflib-3.6.13.ebuild,v 1.1 2004/10/23 12:28:51 usata Exp $

inherit libtool eutils

MY_P="VFlib3-${PV}"

DESCRIPTION="Japanese Vector Font library"
HOMEPAGE="http://typehack.aial.hiroshima-u.ac.jp/VFlib/"
SRC_URI="ftp://typehack.aial.hiroshima-u.ac.jp/pub/TypeHack/${MY_P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="3"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
IUSE=""

DEPEND="=media-libs/freetype-1*
	media-libs/t1lib
	virtual/x11
	virtual/tetex"

S=${WORKDIR}/${MY_P}

src_compile () {
	elibtoolize
	sed -i -e "s:<varargs.h>:<stdarg.h>:" src/vfldisol.c
	if has_version '>=media-libs/t1lib-5' ; then
		sed -i -e "s:T1_Get_no_fonts:T1_GetNoFonts:" src/drv_t1.c
	fi

	econf \
		--with-kpathsea \
		--with-kpathsea-include=/usr/include \
		--with-kpathsea-libdir=/usr/lib \
		--with-freetype \
		--with-freetype-includedir=/usr/include/freetype \
		--with-freetype-libdir=/usr/lib \
		--with-t1lib \
		--with-t1lib-includedir=/usr/include \
		--with-t1lib-libdir=/usr/lib || die

	emake -j1 \
		CDEBUGFLAGS="${CFLAGS}" \
		CXXDEBUGFLAGS="${CXXFLAGS}" || die
}

src_install () {
	einstall \
		runtimedir=${D}/usr/share/VFlib/${PV} \
		runtimesitedir=${D}/usr/share/VFlib/site || die

	dodoc CHANGES COPYING* DISTRIB.txt INSTALL README*
}
