# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/matrixssl/matrixssl-1.0.2.ebuild,v 1.3 2004/07/02 04:52:04 eradicator Exp $

DESCRIPTION="embedded SSL implementation"
HOMEPAGE="http://www.matrixssl.org/"
SRC_URI="${PN}-${PV//./-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
RESTRICT="fetch"

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}/src

pkg_nofetch() {
	einfo "You'll have to visit the website to download the file."
	einfo "http://www.matrixssl.org/download.html"
}

src_compile() {
	emake DFLAGS="${CFLAGS}" || die
}

src_install() {
	dolib.so libmatrixssl.so || die
	cd ..
	if use doc ; then
		dodoc doc/*
		docinto examples
		dodoc examples/*
	fi
	insinto /usr/include
	doins matrixSsl.h || die
}
