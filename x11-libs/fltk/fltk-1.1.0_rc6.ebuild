# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.0_rc6.ebuild,v 1.1 2002/08/22 19:54:54 raker Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV/_/}/${MY_P}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="x86 sparc sparc64"
LICENSE="FLTK | GPL-2"

DEPEND="media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

src_compile() {

	local myconf
	myconf="--enable-shared --enable-threads"

	use opengl || myconf="${myconf} --disable-gl"

	use xft && myconf="${myconf} --enable-xft"

	use xdbe && myconf="${myconf} --enable-xdbe"
	
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
	
	echo "LDPATH=/usr/lib/fltk-1.1" > 99fltk-1.1

	insinto /etc/env.d
	doins 99fltk-1.1
}
