# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.0_rc7.ebuild,v 1.9 2003/09/07 00:23:27 msterret Exp $

IUSE="opengl"

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV/_/}/${MY_P}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="x86 sparc"
LICENSE="FLTK | GPL-2"

DEPEND="media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )
	virtual/x11"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/libs.diff || die "patch failed"

}

src_compile() {

	local myconf
	myconf="--enable-shared --enable-static --enable-threads \
		--enable-xft --enable-xdbe"

	use opengl || myconf="${myconf} --disable-gl"

	econf \
		--includedir=/usr/include/fltk-1.1 \
		--libdir=/usr/lib/fltk-1.1 \
		${myconf} || die "Configuration Failed"

	emake CXX="g++" || die "Parallel Make Failed"

}

src_install () {

	einstall \
		includedir=${D}/usr/include/${PN}-1.1 \
		libdir=${D}/usr/lib/fltk-1.1 || die "Installation Failed"

	ranlib ${D}/usr/lib/fltk-1.1/*.a

	dodoc CHANGES COPYING README

	echo "LDPATH=/usr/lib/fltk-1.1" > 99fltk-1.1

	insinto /etc/env.d
	doins 99fltk-1.1
}
