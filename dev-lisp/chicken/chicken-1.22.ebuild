# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/chicken/chicken-1.22.ebuild,v 1.4 2004/07/13 06:29:17 mr_bones_ Exp $

DESCRIPTION="Chicken is a native Scheme to C compiler"
SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

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
