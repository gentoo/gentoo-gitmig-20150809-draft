# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xclass/xclass-0.8.2.ebuild,v 1.2 2003/12/04 15:43:10 vapier Exp $

DESCRIPTION="a C++ GUI toolkit for the X windows environment"
HOMEPAGE="http://xclass.sourceforge.net/"
SRC_URI="ftp://mitac11.uia.ac.be/pub/xclass/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/x11
	virtual/glibc"

src_unpack() {
	unpack ${A}
	sed -i 's:example-app::' ${S}/Makefile.in
}

src_compile() {
	econf --enable-shared=yes --with-x || die
	if [ `use static` ] ; then
		emake || die "'emake' failed"
	else
		emake shared || die "'emake shared' failed"
	fi
}

src_install() {
	rm -rf `find . -name 'Makefile*'`

	dobin config/xc-config

	dodoc doc/*

	dodir /usr/share/xclass
	insinto /usr/share/xclass
	mv "icons/Lock screen.s.xpm" ${D}/usr/share/xclass/
	doins icons/*.xpm

	dodir /usr/include/xclass
	insinto /usr/include/xclass
	doins include/xclass/*.h

	dolib lib/libxclass/lib*
}
