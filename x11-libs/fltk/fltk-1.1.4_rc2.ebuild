# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.4_rc2.ebuild,v 1.1 2003/08/14 20:13:32 g2boojum Exp $

IUSE="opengl debug"

inherit eutils

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV/_/}/${P/_/}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="FLTK | GPL-2"

DEPEND="virtual/x11
	virtual/xft
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${P/_/}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libs.diff || die "patch failed"
}

src_compile() {
	local myconf="--enable-shared --enable-threads \
		--enable-xdbe --enable-xft --enable-static"

	use debug && myconf="${myconf} --enable-debug"

	use opengl || myconf="${myconf} --disable-gl"

	# needed for glibc-2.3.1 (as far as i can test)
	# otherwise libstdc++ won't be linked. #17894 and #15572
	# doesn't happen for glibc-2.3.2 - <liquidx@gentoo.org>
	export CXX="g++"
	export CC="g++"
	
	# bug #19894
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"	
    
	econf \
		--includedir=/usr/include/fltk-1.1 \
		--libdir=/usr/lib/fltk-1.1 \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	einstall \
		includedir=${D}/usr/include/fltk-1.1 \
		libdir=${D}/usr/lib/fltk-1.1 || die "Installation Failed"

	ranlib ${D}/usr/lib/fltk-1.1/*.a

	dodoc CHANGES COPYING README
	
	echo "LDPATH=/usr/lib/fltk-1.1" > 99fltk-1.1

	insinto /etc/env.d
	doins 99fltk-1.1

	dodir /usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${P}/html
}
