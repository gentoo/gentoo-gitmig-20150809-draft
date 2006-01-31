# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/matrixssl/matrixssl-1.7.3.ebuild,v 1.1 2006/01/31 01:18:37 vapier Exp $

inherit eutils

DESCRIPTION="embedded SSL implementation"
HOMEPAGE="http://www.matrixssl.org/"
SRC_URI="mirror://gentoo/${PN}-${PV//./-}-open.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""

S=${WORKDIR}/${PN}/src

pkg_nofetch() {
	einfo "You'll have to visit the website to download the file."
	einfo "http://www.matrixssl.org/download.html"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
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
	doins *.h || die
}
