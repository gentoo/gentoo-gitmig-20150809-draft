# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbill/xbill-2.1.ebuild,v 1.3 2004/01/24 13:17:38 mr_bones_ Exp $

DESCRIPTION="A game about evil hacker called Bill!"
HOMEPAGE="http://www.xbill.org"
SRC_URI="http://www.xbill.org/download/${P}.tar.gz"

KEYWORDS="x86 ppc ~amd64"
LICENSE="GPL-1"
SLOT="0"
IUSE=""

DEPEND=">=gtk+-1.0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var \
		--enable-gtk || die "./configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
}
