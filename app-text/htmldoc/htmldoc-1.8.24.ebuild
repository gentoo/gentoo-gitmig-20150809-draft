# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmldoc/htmldoc-1.8.24.ebuild,v 1.6 2005/08/03 21:00:17 kloeri Exp $

DESCRIPTION="Convert HTML pages into a PDF document"
SRC_URI="http://ftp.easysw.com/pub/${PN}/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.easysw.com/htmldoc/"

IUSE="X ssl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ppc sparc x86"

DEPEND="X? ( virtual/x11 )"
RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6e )
	X? ( >=x11-libs/fltk-1.0.11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s@^#define DOCUMENTATION \"\$prefix/share/doc/htmldoc\"@#define DOCUMENTATION \"\$prefix/share/doc/${PF}/html\"@" \
		configure
}

src_compile() {
	local myconf
	use X && myconf="--with-x --with-gui"
	use ssl && myconf="${myconf} --with-openssl-libs=/usr/lib \
		--with-openssl-includes=/usr/include/openssl"

	econf ${myconf} || die "econf failed"

	# Add missing -lfltk_images to LIBS
	use X && sed -i 's/-lfltk /-lfltk -lfltk_images /g' Makedefs

	make || die "make failed"
}

src_install() {
	einstall bindir=${D}/usr/bin || die

	# Minor cleanups
	mv ${D}/usr/share/doc/htmldoc ${D}/usr/share/doc/${PF}
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/*.html ${D}/usr/share/doc/${PF}/html
}
