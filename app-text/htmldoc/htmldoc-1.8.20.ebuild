# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/htmldoc/htmldoc-1.8.20.ebuild,v 1.1 2002/08/06 15:46:22 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Convert HTML pages into a PDF document"
SRC_URI="ftp://ftp.easysw.com/pub/htmldoc/1.8.20/${P}-1-source.tar.bz2"
HOMEPAGE="http://www.easysw.com/htmldoc"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/x11"
RDEPEND=">=dev-libs/openssl-0.9.6e
	>=x11-libs/fltk-1.0.11"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/fonts.diff || die "patch failed"

}

src_compile() {
	econf \
		--with-x \
		--with-gui \
		--with-openssl-libs=/usr/lib \
		--with-openssl-includes=/usr/include/openssl || die
	
	# Add missing -lfltk_images to LIBS
	#
	mv Makedefs Makedefs.orig
	cat ${S}/Makedefs.orig | sed -e 's/-lfltk /-lfltk -lfltk_images /g' \
		> Makedefs || die "failed to detect -lfltk"
		
	make || die
}


src_install() {

	einstall || die

	# Minor cleanups
	mv ${D}/usr/share/doc/htmldoc ${D}/usr/share/doc/${P}
	dodir /usr/share/doc/${P}/html
	mv ${D}/usr/share/doc/${P}/*.html ${D}/usr/share/doc/${P}/html

}
