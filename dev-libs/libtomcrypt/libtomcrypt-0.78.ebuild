# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtomcrypt/libtomcrypt-0.78.ebuild,v 1.1 2002/12/05 20:57:31 vapier Exp $

DESCRIPTION="http://libtomcrypt.iahu.ca/"
HOMEPAGE="http://libtomcrypt.iahu.ca/"
SRC_URI="http://iahu.ca:8080/download/crypt-${PV}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/include/${PN}
	dodir /usr/lib
	make LIBPATH=${D}/usr/lib INCPATH=${D}/usr/include/${PN} install
}
