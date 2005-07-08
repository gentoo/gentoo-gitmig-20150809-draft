# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qe/qe-0.1.1.ebuild,v 1.10 2005/07/08 17:52:58 dholm Exp $

DESCRIPTION="PE2-like editor program under U*nix with Chinese support"
HOMEPAGE="http://www.cc.ncu.edu.tw/~center5/product/qe/ http://members.xoom.com/linux4tw/qe/"
SRC_URI="ftp://freebsd.sinica.edu.tw/pub/statue/qe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	./configure --prefix=/usr || die
	make all || die
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS ChangeLog README README.big5
}
