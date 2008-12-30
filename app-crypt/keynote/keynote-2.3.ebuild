# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keynote/keynote-2.3.ebuild,v 1.10 2008/12/30 18:37:26 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="The KeyNote Trust-Management System"
HOMEPAGE="http://www1.cs.columbia.edu/~angelos/keynote.html"
SRC_URI="http://www1.cs.columbia.edu/~angelos/Code/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^CFLAGS/s/-O2/${CFLAGS}/" \
		-e "/^AR/d" Makefile.in || die "sed failed"
}

src_compile() {
	tc-export AR CC RANLIB
	econf
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
