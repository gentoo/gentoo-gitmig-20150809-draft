# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fxscintilla/fxscintilla-1.62.ebuild,v 1.5 2006/03/29 05:09:59 rphillips Exp $

DESCRIPTION="A free source code editing component for the FOX-Toolkit"
HOMEPAGE="http://www.nongnu.org/fxscintilla"
SRC_URI="http://savannah.nongnu.org/download/fxscintilla/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64 alpha hppa"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND=">=x11-libs/fox-1.2.6"

src_compile () {
	econf --enable-shared || die "Configure failed"
	emake || die "Make failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README INSTALL

	# give libraries the .so
	mv ${D}/usr/lib/libfxscintilla.16.0.0 ${D}/usr/lib/libfxscintilla.so.16.0.0
	rm -f ${D}/usr/lib/libfxscintilla.16
	rm -f ${D}/usr/lib/libfxscintilla
	ln -s ${D}/usr/lib/libfxscintilla.so.16.0.0 ${D}/usr/lib/libfxscintilla.so.16
	ln -s ${D}/usr/lib/libfxscintilla.so.16.0.0 ${D}/usr/lib/libfxscintilla.so
}
