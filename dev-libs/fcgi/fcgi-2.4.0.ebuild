# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fcgi/fcgi-2.4.0.ebuild,v 1.20 2006/04/22 11:06:16 flameeyes Exp $

DESCRIPTION="FastCGI Developer's Kit"
HOMEPAGE="http://www.fastcgi.com/"
SRC_URI="http://www.fastcgi.com/dist/${P}.tar.gz"
LICENSE="FastCGI"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ~mips ppc ~ppc-macos ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf || die "econf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install LIBRARY_PATH=${D}/usr/lib || die
	dodoc LICENSE.TERMS README
	mv doc/*.[13] . && doman *.[13]
	dohtml doc/*
	insinto /usr/share/doc/${P}/examples
	doins examples/*.c
	insinto /usr/share/doc/${P}/images
	doins images/*
}
