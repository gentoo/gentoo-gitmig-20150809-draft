# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.2-r1.ebuild,v 1.1 2003/01/09 03:51:16 raker Exp $

IUSE="opengl"

S=${WORKDIR}/${P}

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV}/${P}-source.tar.bz2"

SLOT="1.1"
KEYWORDS="x86 ppc sparc"
LICENSE="FLTK | GPL-2"

DEPEND="virtual/x11
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

inherit eutils

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libs.diff || die "patch failed"

}

src_compile() {

	local myconf
	myconf="--enable-shared --enable-static --enable-threads \
		--enable-xdbe"

	# If you still have problems and you just uninstalled
	# xft and didn't re-install xfree to get the right headers
	# back the xft enabled build still wont work. :) I hope to fix
	# this eventually but for the 1.4 release...
	if [ -d ${ROOT}var/db/pkg/x11-libs/xft* ]; then
		myconf="${myconf} --disable-xft"
	else
		myconf="${myconf} --enable-xft"
	fi

	use opengl || myconf="${myconf} --disable-gl"

	export CXX="g++"

	econf \
		--includedir=/usr/include/fltk-1.1 \
		--libdir=/usr/lib/fltk-1.1 \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"

}

src_install () {

	einstall \
		includedir=${D}/usr/include/fltk-1.1 \
		libdir=${D}/usr/lib/fltk-1.1 || die "Installation Failed"

	ranlib ${D}/usr/lib/fltk-1.1/*.a

	dodoc CHANGES COPYING README
	
	echo "LDPATH=/usr/lib/fltk-1.1" > 99fltk-1.1

	insinto /etc/env.d
	doins 99fltk-1.1
}
