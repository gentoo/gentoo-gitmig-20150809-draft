# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/pspell/pspell-0.12.2.ebuild,v 1.3 2002/04/28 03:59:29 seemant Exp $

MY_P=${P/0/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A spell checker frontend for aspell and ispell"
SRC_URI="http://download.sourceforge.net/pspell/${MY_P}.tar.gz"
HOMEPAGE="http://pspell.sourceforge.net"

DEPEND="virtual/glibc"


src_compile() {

	./configure \
		--prefix=/usr \
		--enable-doc-dir=/usr/share/doc/${P} || die

	make || die
}

src_install () {

	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	mv man-html html
	mv man-text txt
	cd ${S}
	dodoc README*

}
