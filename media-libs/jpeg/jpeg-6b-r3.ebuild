# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r3.ebuild,v 1.8 2003/01/31 18:50:10 seemant Exp $

inherit gnuconfig flag-o-matic

MY_P=${PN}src.v${PV}
DESCRIPTION="Library to load, handle and manipulate images in the JPEG format"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"
HOMEPAGE="http://www.ijg.org/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

export CFLAGS="${CFLAGS/k6-3/i586}"
export CFLAGS="${CFLAGS/k6-2/i586}"
export CFLAGS="${CFLAGS/k6/i586}"
export CXXFLAGS="${CFLAGS}"

src_unpack() {
	unpack ${A}

	# allow /etc/make.conf's HOST setting to apply
	cd ${S}
	cp configure configure.orig 
	sed 's/ltconfig.*/& $chost/' configure.orig > configure
	use alpha && gnuconfig_update
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
