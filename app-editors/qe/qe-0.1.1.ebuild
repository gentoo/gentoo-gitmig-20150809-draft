# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qe/qe-0.1.1.ebuild,v 1.4 2003/06/29 18:24:09 aliz Exp $

DESCRIPTION="PE2-like editor program under U*nix with Chinese support"
HOMEPAGE="http://www.cc.ncu.edu.tw/~center5/product/qe/
	http://members.xoom.com/linux4tw/qe/"
SRC_URI="ftp://freebsd.sinica.edu.tw/pub/statue/qe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr || die
	make all || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS ChangeLog README README.big5
}
