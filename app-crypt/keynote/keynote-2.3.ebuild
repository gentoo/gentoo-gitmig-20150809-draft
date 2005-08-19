# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keynote/keynote-2.3.ebuild,v 1.8 2005/08/19 04:01:54 metalgod Exp $

DESCRIPTION="The KeyNote Trust-Management System"
HOMEPAGE="http://www1.cs.columbia.edu/~angelos/keynote.html"
SRC_URI="http://www1.cs.columbia.edu/~angelos/Code/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="ssl"

DEPEND="virtual/libc
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
	dobin keynote || die

	doman man/keynote.[1345]

	dolib.a libkeynote.a

	insinto /usr/include
	doins keynote.h

	dodoc README HOWTO.add.crypto TODO
}
