# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r3.ebuild,v 1.13 2003/05/11 17:45:56 gmsoft Exp $

inherit gnuconfig flag-o-matic

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"
HOMEPAGE="http://www.ijg.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa arm"

DEPEND="virtual/glibc"

replace-flags k6-3 i586
replace-flags k6-2 i586
replace-flags k6 i586

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	cp configure configure.orig 
	sed 's/ltconfig.*/& $CHOST/' configure.orig > configure
	use alpha && gnuconfig_update
	use hppa && gnuconfig_update
}

src_compile() {
	econf --enable-shared --enable-static

	make || die
}

src_install() {
	dodir /usr/{include,lib,bin,share/man/man1}
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die

	dodoc README change.log structure.doc
}
