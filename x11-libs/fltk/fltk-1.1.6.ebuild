# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.6.ebuild,v 1.1 2005/06/17 17:47:02 smithj Exp $

IUSE="X opengl debug"

inherit eutils toolchain-funcs

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="http://ftp.easysw.com/pub/${PN}/${PV}/${P}-source.tar.bz2"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~mips ~ppc64"
LICENSE="FLTK GPL-2"

PV_MAJOR=${PV/.*/}
PV_MINOR=${PV#${PV_MAJOR}.}
PV_MINOR=${PV_MINOR/.*}
SLOT="${PV_MAJOR}.${PV_MINOR}"

INCDIR=/usr/include/fltk-${SLOT}
LIBDIR=/usr/lib/fltk-${SLOT}

DEPEND="virtual/x11
	X? ( virtual/xft )
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	# Upstream fix from cvs to fix the 'back' button in the help window
	cd ${S}
	epatch ${FILESDIR}/Fl_Help_View.cxx.patch || die "Patch failed!"
	epatch ${FILESDIR}/libs-1.6.diff || die "patch failed"
}

src_compile() {
	local myconf
	myconf="--enable-shared --enable-xdbe --enable-static --enable-threads"

	if use X; then
		myconf="${myconf} --enable-xft"
	else
		myconf="${myconf} --disable-xft"
	fi

	use debug && myconf="${myconf} --enable-debug"

	use opengl || myconf="${myconf} --disable-gl"

	# needed for glibc-2.3.1 (as far as i can test)
	# otherwise libstdc++ won't be linked. #17894 and #15572
	# doesn't happen for glibc-2.3.2 - <liquidx@gentoo.org>
	export CXX=$(tc-getCXX)
	export CC=$(tc-getCC)

	# bug #19894
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	econf \
		--includedir=${INCDIR}\
		--libdir=${LIBDIR} \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install() {
	einstall \
		includedir=${D}${INCDIR} \
		libdir=${D}${LIBDIR} || die "Installation Failed"

	ranlib ${D}${LIBDIR}/*.a

	dodoc CHANGES COPYING README

	echo "LDPATH=${LIBDIR}" > 99fltk-${SLOT}
	echo "FLTK_DOCDIR=/usr/share/doc/${PF}/html" >> 99fltk-${SLOT}

	insinto /etc/env.d
	doins 99fltk-${SLOT}

	dodir /usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/fltk
}
