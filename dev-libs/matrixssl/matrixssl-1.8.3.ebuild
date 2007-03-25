# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/matrixssl/matrixssl-1.8.3.ebuild,v 1.1 2007/03/25 17:02:33 vapier Exp $

inherit eutils

MY_P=${P//./-}
DESCRIPTION="embedded SSL implementation"
HOMEPAGE="http://www.matrixssl.org/"
SRC_URI="mirror://gentoo/${MY_P}-open.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=""

S=${WORKDIR}/${MY_P}-open/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.8.3-build.patch
}

src_install() {
	dolib.so libmatrixssl.so || die
	dolib.a libmatrixssl.a || die
	insinto /usr/include
	cd ..
	doins matrixCommon.h matrixSsl.h || die
	if use doc ; then
		cd "${S}"/..
		dodoc doc/* || die
	fi
	if use examples ; then
		cd "${S}"/..
		docinto examples
		dodoc examples/* || die
	fi
}
