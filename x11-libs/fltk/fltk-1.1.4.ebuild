# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.4.ebuild,v 1.18 2005/08/23 21:12:21 agriffis Exp $

IUSE="opengl debug nptl"

inherit eutils toolchain-funcs multilib

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="ftp://ftp.easysw.com/pub/fltk/${PV}/${P}-source.tar.bz2"

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
LICENSE="FLTK LGPL-2"

PV_MAJOR=${PV/.*/}
PV_MINOR=${PV#${PV_MAJOR}.}
PV_MINOR=${PV_MINOR/.*}
SLOT="${PV_MAJOR}.${PV_MINOR}"

INCDIR=/usr/include/fltk-${SLOT}
LIBDIR=/usr/$(get_libdir)/fltk-${SLOT}

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
	myconf="--enable-shared --enable-xdbe --enable-xft --enable-static"

	use debug && myconf="${myconf} --enable-debug"

	use opengl || myconf="${myconf} --disable-gl"

	# The fltk threading code doesn't work with nptl
	# See bug #26569
	use nptl && myconf="${myconf} --disable-threads" \
		|| myconf="${myconf} --enable-threads"

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

	insinto /etc/env.d
	doins 99fltk-${SLOT}

	dodir /usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/fltk
	rm -rf ${D}/usr/share/man/cat{1,3}
}
