# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keynote/keynote-2.3.ebuild,v 1.3 2004/06/01 23:14:59 agriffis Exp $

DESCRIPTION="The KeyNote Trust-Management System"
HOMEPAGE="http://www1.cs.columbia.edu/~angelos/keynote.html"
SRC_URI="http://www1.cs.columbia.edu/~angelos/Code/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

src_compile() {

	econf || die
	if use ssl; then
		make || die
	else
		make nocrypto || die
	fi

}

src_install() {

	dobin keynote

	doman man/keynote.1
	doman man/keynote.3
	doman man/keynote.4
	doman man/keynote.5

	dolib.a libkeynote.a

	insinto /usr/include
	doins keynote.h

	dodoc README HOWTO.add.crypto TODO LICENSE

}
