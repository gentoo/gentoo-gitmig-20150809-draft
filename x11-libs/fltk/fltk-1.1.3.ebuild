# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.3.ebuild,v 1.1 2003/05/16 11:18:18 liquidx Exp $

inherit eutils

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV}/${P}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="FLTK | GPL-2"
IUSE="opengl"

DEPEND="virtual/x11
	virtual/xft
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libs.diff || die "patch failed"
}

src_compile() {
	local myconf
	myconf="--enable-shared --enable-static --enable-threads \
		--enable-xdbe --enable-xft"

	# If you still have problems and you just uninstalled
	# xft and didn't re-install xfree to get the right headers
	# back the xft enabled build still wont work. :) I hope to fix
	# this eventually but for the 1.4 release...
	#if [ -d ${ROOT}var/db/pkg/x11-libs/xft* ]; then
	#	myconf="${myconf} --disable-xft"
	#else
	#	myconf="${myconf} --enable-xft"
	#fi

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
}
