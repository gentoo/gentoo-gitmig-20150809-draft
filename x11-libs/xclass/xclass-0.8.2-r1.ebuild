# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xclass/xclass-0.8.2-r1.ebuild,v 1.2 2004/06/19 14:32:19 pyrania Exp $

DESCRIPTION="a C++ GUI toolkit for the X windows environment"
HOMEPAGE="http://xclass.sourceforge.net/"
SRC_URI="ftp://mitac11.uia.ac.be/pub/xclass/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE="static"

DEPEND="virtual/x11
	virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:example-app::' Makefile.in
	sed -i \
		-e 's:/usr/local/xclass-icons:/usr/share/icons/xclass:' \
		-e 's:/usr/local/xclass:/:' \
		lib/libxclass/Makefile.in
	sed -i \
		-e 's:/usr/local/xclass/icons:/usr/share/icons/xclass:' \
		-e 's:mime\.types:xclass.mime.types:' \
		doc/xclassrc
}

src_compile() {
	econf --enable-shared=yes --with-x || die
	if use static ; then
		emake || die "'emake' failed"
	else
		emake shared || die "'emake shared' failed"
	fi
}

src_install() {
	rm -rf `find . -name 'Makefile*'`

	dobin config/xc-config || die

	insinto /etc
	doins doc/xclassrc || die
	newins doc/mime.types xclass.mime.types || die

	dodoc doc/*

	dodir /usr/share/icons/xclass
	insinto /usr/share/icons/xclass
	mv "icons/Lock screen.s.xpm" ${D}/usr/share/icons/xclass/
	doins icons/*.xpm || die

	dodir /usr/include/xclass
	insinto /usr/include/xclass
	doins include/xclass/*.h || die

	dolib lib/libxclass/lib* || die
}
