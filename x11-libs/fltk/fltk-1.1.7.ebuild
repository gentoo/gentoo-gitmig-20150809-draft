# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.1.7.ebuild,v 1.8 2006/04/20 12:51:04 tcort Exp $

IUSE="noxft opengl debug"

inherit eutils toolchain-funcs multilib

DESCRIPTION="C++ user interface toolkit for X and OpenGL."
HOMEPAGE="http://www.fltk.org"
SRC_URI="http://ftp.easysw.com/pub/${PN}/${PV}/${P}-source.tar.bz2"

KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
LICENSE="FLTK LGPL-2"

PV_MAJOR=${PV/.*/}
PV_MINOR=${PV#${PV_MAJOR}.}
PV_MINOR=${PV_MINOR/.*}
SLOT="${PV_MAJOR}.${PV_MINOR}"

INCDIR=/usr/include/fltk-${SLOT}
LIBDIR=/usr/$(get_libdir)/fltk-${SLOT}

DEPEND="|| ( (
		x11-libs/libXext
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXt
		x11-proto/xextproto )
	virtual/x11 )
	!noxft? ( virtual/xft )
	media-libs/libpng
	media-libs/jpeg
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libs-1.7.diff || die "patch failed"
}

src_compile() {
	local myconf
	myconf="--enable-shared --enable-xdbe --enable-static --enable-threads"

	if ! use noxft; then
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

	dodoc CHANGES README

	echo "LDPATH=${LIBDIR}" > 99fltk-${SLOT}
	echo "FLTK_DOCDIR=/usr/share/doc/${PF}/html" >> 99fltk-${SLOT}

	insinto /etc/env.d
	doins 99fltk-${SLOT}

	dodir /usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/fltk/* ${D}/usr/share/doc/${PF}/html
	rmdir ${D}/usr/share/doc/fltk
	rm -rf ${D}/usr/share/man/cat{1,3}
}

pkg_postinst() {
	ewarn "the xft USE flag has been changed to noxft. this was because most"
	ewarn "users want xft, but if you do not, be sure to change the flag"
}
