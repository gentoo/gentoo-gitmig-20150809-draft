# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/chicken/chicken-1.22.ebuild,v 1.1 2003/11/21 02:55:17 mkennedy Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Chicken is a native Scheme to C compiler"
SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz"
HOMEPAGE="http://www.call-with-current-continuation.org/"
LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"

DEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog AUTHORS NEWS README THANKS TODO
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/chicken/doc/manual/ ${D}/usr/share/doc/${PF}/html/
	rm -rf ${D}/usr/share/chicken/doc
}
