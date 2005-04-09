# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/chicken/chicken-1.89.ebuild,v 1.2 2005/04/09 08:48:25 blubb Exp $

inherit multilib

DESCRIPTION="Chicken is a Scheme interpreter and native Scheme to C compiler"
SRC_URI="http://www.call-with-current-continuation.org/${P}.tar.gz"
HOMEPAGE="http://www.call-with-current-continuation.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir)
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
	make check || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog AUTHORS NEWS README THANKS TODO
	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/share/chicken/doc/manual/ ${D}/usr/share/doc/${PF}/html/
	rm -rf ${D}/usr/share/chicken/doc
}
