# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.0_rc5.ebuild,v 1.1 2002/08/12 14:33:14 seemant Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV/_/}/${MY_P}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="x86"
LICENSE="FLTK | GPL-2"

DEPEND="media-libs/libpng
	opengl? ( virtual/opengl )"

src_compile() {

	local myconf
	myconf="--enable-shared"

	use opengl || myconf="${myconf} --disable-gl"
	
	econf \
		--includedir=/usr/include/${PN}-1.1 \
		--libdir=/usr/lib/fltk-1.1 \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"

}

src_install () {

	einstall \
		includedir=${D}/usr/include/${PN}-1.1 \
		libdir=${D}/usr/lib/fltk-1.1 || die "Installation Failed"
		
	dodoc CHANGES COPYING README
	
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/fltk
}
