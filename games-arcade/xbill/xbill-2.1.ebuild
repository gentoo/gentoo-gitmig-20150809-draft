# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbill/xbill-2.1.ebuild,v 1.1 2003/09/10 19:29:22 vapier Exp $

DESCRIPTION="A game about evil hacker called Bill!"

HOMEPAGE="http://www.xbill.org"
KEYWORDS="x86 ppc"

LICENSE="GPL-1"
SLOT="0"

DEPEND=">=gtk+-1.0"

SRC_URI="http://www.xbill.org/download/${P}.tar.gz"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
}


src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var \
		--enable-gtk || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
}
