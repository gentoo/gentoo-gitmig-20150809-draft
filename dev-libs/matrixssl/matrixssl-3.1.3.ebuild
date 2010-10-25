# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/matrixssl/matrixssl-3.1.3.ebuild,v 1.1 2010/10/25 16:23:27 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

MY_P=${P//./-}-open

DESCRIPTION="embedded SSL implementation"
HOMEPAGE="http://www.matrixssl.org/"
SRC_URI="http://dev.gentoo.org/~ssuominen/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		STRIP="true" \
		AR="$(tc-getAR)" \
		DFLAGS="${CFLAGS}" || die
}

src_install() {
	dolib.so libmatrixssl.so || die
	dolib.a libmatrixssl.a || die

	# API is exposed from matrixsslApi.h and rest is included recursively
	insinto /usr/include/matrixssl
	doins matrixssl/*.h || die

	insinto /usr/include/matrixssl/core
	doins core/*.h || die

	insinto /usr/include/matrixssl/crypto
	doins crypto/*.h || die
	insinto /usr/include/matrixssl/crypto/digest
	doins crypto/digest/*.h || die
	insinto /usr/include/matrixssl/crypto/keyformat
	doins crypto/keyformat/*.h || die
	insinto /usr/include/matrixssl/crypto/math
	doins crypto/math/*.h || die
	insinto /usr/include/matrixssl/crypto/prng
	doins crypto/prng/*.h || die
	insinto /usr/include/matrixssl/crypto/pubkey
	doins crypto/pubkey/*.h || die
	insinto /usr/include/matrixssl/crypto/symmetric
	doins crypto/symmetric/*.h || die

	if use doc; then
		insinto /usr/share/doc/${PF}/pdf
		doins doc/*.pdf
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r apps sampleCerts
	fi

	dodoc readme.txt
}
