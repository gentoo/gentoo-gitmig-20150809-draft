# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmldoc/htmldoc-1.8.23.ebuild,v 1.4 2003/09/05 22:37:21 msterret Exp $

DESCRIPTION="Convert HTML pages into a PDF document"
SRC_URI="ftp://ftp.easysw.com/pub/${PN}/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.easysw.com/htmldoc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~ppc"

DEPEND="virtual/x11"
RDEPEND=">=dev-libs/openssl-0.9.6e
	>=x11-libs/fltk-1.0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s@^#define DOCUMENTATION \"\$prefix/share/doc/htmldoc\"@#define DOCUMENTATION \"\$prefix/share/doc/${PF}/html\"@" \
		configure
}

src_compile() {
	econf \
		--with-x \
		--with-gui \
		--with-openssl-libs=/usr/lib \
		--with-openssl-includes=/usr/include/openssl

	# Add missing -lfltk_images to LIBS
	sed -i 's/-lfltk /-lfltk -lfltk_images /g' \
		Makedefs || die "failed to detect -lfltk"

	make || die
}

src_install() {
	einstall

	# Minor cleanups
	mv ${D}/usr/share/doc/htmldoc ${D}/usr/share/doc/${PF}
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/html
}
