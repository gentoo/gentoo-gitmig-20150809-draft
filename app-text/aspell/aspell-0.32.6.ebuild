# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.32.6.ebuild,v 1.4 2002/04/28 03:59:29 seemant Exp $


MY_P=${PN}-.32.6
S=${WORKDIR}/${MY_P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${MY_P}.tar.gz"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.11.2"

src_compile() {

	./configure --prefix=/usr --sysconfdir=/etc/aspell --host=${CHOST} || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodir /usr/share/doc
	mv ${D}/usr/doc/aspell ${D}/usr/share/doc/${PF}
	mv ${D}/usr/share/doc/${PF}/man-html ${D}/usr/share/doc/${PF}/html
	mv ${D}/usr/share/doc/${PF}/man-text ${D}/usr/share/doc/${PF}/aspell

	dodoc README* TODO
}
