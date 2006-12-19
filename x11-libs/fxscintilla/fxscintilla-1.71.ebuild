# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fxscintilla/fxscintilla-1.71.ebuild,v 1.3 2006/12/19 15:34:45 fmccor Exp $

inherit eutils

DESCRIPTION="A free source code editing component for the FOX-Toolkit"
HOMEPAGE="http://www.nongnu.org/fxscintilla/"
SRC_URI="http://savannah.nongnu.org/download/fxscintilla/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="=x11-libs/fox-1.2*
	=x11-libs/fox-1.4*
	=x11-libs/fox-1.6*"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/1.71-shared-libs.patch || die
	epatch ${FILESDIR}/1.71-fox-SLOT.patch || die

	einfo "Running autoreconf..."
	touch NEWS AUTHORS
	autoreconf --install --force || die "autoreconf error"
}

src_compile () {
	# Borrowed from wxGTK ebuild

	einfo "Building ${PN} for FOX-1.2..."
	mkdir ${S}/build_1_2
	cd ${S}/build_1_2
	../configure \
		--prefix=/usr \
		--includedir=/usr/include \
		--libdir=/usr/lib \
		${EXTRA_ECONF} \
		--enable-nolexer \
		--with-fox-1-2 \
		--with-foxinclude=${ROOT}usr/include \
		--with-foxlib=${ROOT}usr/lib \
		|| die "configure error"
	emake || die "make error"

	einfo "Building ${PN} for FOX-1.4..."
	mkdir ${S}/build_1_4
	cd ${S}/build_1_4
	../configure \
		--prefix=/usr \
		--includedir=/usr/include \
		--libdir=/usr/lib \
		${EXTRA_ECONF} \
		--enable-nolexer \
		--with-fox-1-4 \
		--with-foxinclude=${ROOT}usr/include \
		--with-foxlib=${ROOT}usr/lib \
		|| die "configure error"
	emake || die "make error"

	einfo "Building ${PN} for FOX-1.6..."
	mkdir ${S}/build_1_6
	cd ${S}/build_1_6
	../configure \
		--prefix=/usr \
		--includedir=/usr/include \
		--libdir=/usr/lib \
		${EXTRA_ECONF} \
		--enable-nolexer \
		--with-fox-1-6 \
		--with-foxinclude=${ROOT}usr/include \
		|| die "configure error"
	emake || die "make error"
}

src_install () {
	cd ${S}/build_1_2
	make DESTDIR="${D}" install || die "make install error"

	cd ${S}/build_1_4
	make DESTDIR="${D}" install || die "make install error"

	cd ${S}/build_1_6
	make DESTDIR="${D}" install || die "make install error"

	cd ${S}
	dodoc README
	if use doc ; then
		dodoc scintilla/doc/Lexer.txt
		dohtml scintilla/doc/*
	fi
}

pkg_postinst() {
	ewarn
	ewarn "New as of 1.71:"
	ewarn "FXScintilla is now built separately against FOX-1.2,-1.4 and -1.6."
	ewarn "Support for FOX-1.0 has been dropped upstream."
	ewarn "The Librarys are named for the FOX-release they correspond to, for"
	ewarn "example: For FOX-1.2, the library is called libfxscintilla-1.2."
	ewarn "Anything linked against previous releases of FOX and fxscintilla"
	ewarn "may need to be rebuilt."
	ewarn
	einfo "The nolexer libraries are now included in this release as well."
	epause 5
}
