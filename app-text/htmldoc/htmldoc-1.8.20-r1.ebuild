# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmldoc/htmldoc-1.8.20-r1.ebuild,v 1.3 2003/09/05 22:37:21 msterret Exp $

DESCRIPTION="Convert HTML pages into a PDF document"
SRC_URI="ftp://ftp.easysw.com/pub/htmldoc/1.8.20/${P}-1-source.tar.bz2"
HOMEPAGE="http://www.easysw.com/htmldoc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"

DEPEND="virtual/x11"
RDEPEND=">=dev-libs/openssl-0.9.6e
	>=x11-libs/fltk-1.0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/fonts.diff || die "patch failed"
	## fix path for online-help:
	cp -a configure configure.org
	cat configure.org |\
		sed -e "s@^#define DOCUMENTATION \"\$prefix/share/doc/htmldoc\"@#define DOCUMENTATION \"\$prefix/share/doc/${PF}/html\"@" \
		> configure
}

src_compile() {
	econf \
		--with-x \
		--with-gui \
		--with-openssl-libs=/usr/lib \
		--with-openssl-includes=/usr/include/openssl

	# Add missing -lfltk_images to LIBS
	mv Makedefs Makedefs.orig
	sed -e 's/-lfltk /-lfltk -lfltk_images /g' \
		Makedefs.orig > Makedefs || die "failed to detect -lfltk"

	make || die
}

src_install() {
	einstall

	# Minor cleanups
	mv ${D}/usr/share/doc/htmldoc ${D}/usr/share/doc/${PF}
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/html
}
