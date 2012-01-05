# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/keynote/keynote-2.3-r2.ebuild,v 1.1 2012/01/05 13:09:58 xmw Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="The KeyNote Trust-Management System"
HOMEPAGE="http://www1.cs.columbia.edu/~angelos/keynote.html"
SRC_URI="http://www1.cs.columbia.edu/~angelos/Code/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	cp -av Makefile.in{,.orig}
	epatch "${FILESDIR}"/${P}-make.patch
	epatch "${FILESDIR}"/$P-parallel-build.patch
}

src_configure() {
	tc-export AR CC RANLIB
	econf
}

src_compile() {
	if use ssl; then
		emake || die
	else
		emake nocrypto || die
	fi
}

src_install() {
	dobin keynote || die

	dolib.a libkeynote.a

	insinto /usr/include
	doins keynote.h

	doman man/keynote.[1345]
	dodoc README HOWTO.add.crypto TODO
}
