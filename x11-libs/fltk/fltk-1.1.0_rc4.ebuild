# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.0_rc4.ebuild,v 1.1 2002/07/16 23:02:17 seemant Exp $

MYVER=${PV/_/}
S=${WORKDIR}/${PN}-${MYVER}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${MYVER}/${PN}-${MYVER}-source.tar.bz2"

DEPEND="media-libs/libpng
	opengl? ( virtual/opengl )"

LICENSE="FLTK | GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {

	local myconf
	#shared libraries are disabled by default, so we enable them here
	myconf="--enable-shared"

	use opengl || myconf="$myconf --disable-gl" #default enabled
	
	econf \
		${myconf} || die "Configuration Failed"
		
	emake || die "Parallel Make Failed"

}

src_install () {

	#make prefix=${D}/usr/ \
	einstall || die "Installation Failed"
		
	dodoc CHANGES COPYING README
	
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/fltk

}

