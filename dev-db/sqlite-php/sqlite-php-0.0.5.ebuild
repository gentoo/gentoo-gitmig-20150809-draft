# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlite-php/sqlite-php-0.0.5.ebuild,v 1.1 2002/12/04 22:02:30 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PHP bindings for SQLite"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/sqlite-php/"
DEPEND="virtual/glibc
	>=dev-php/php-4.2
	>=dev-db/sqlite-2.7"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	
	phpize
	./configure --host=${CHOST} --with-sqlite=shared || die
	make || die

}

src_install () {

	mkdir -p ${D}/usr/lib/apache-extramodules
	cp ${S}/modules/sqlite.so ${D}/usr/lib/apache-extramodules
	dodoc README CREDITS CHANGES 

}

pkg_postinst() {

	echo " "
	einfo "You will need to add "extension=sqlite.so" to php.ini first."
	echo " "

}
