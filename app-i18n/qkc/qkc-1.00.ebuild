# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qkc/qkc-1.00.ebuild,v 1.7 2004/04/27 08:18:03 vapier Exp $

inherit gcc

MY_P="${PN}c${PV/./}"
DESCRIPTION="Quick KANJI code Converter"
HOMEPAGE="http://hp.vector.co.jp/authors/VA000501/"
SRC_URI="http://hp.vector.co.jp/authors/VA000501/${MY_P}.zip"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc amd64"
IUSE=""

DEPEND="virtual/glibc
	app-arch/unzip"

S=${WORKDIR}

src_compile() {
	make CC="$(gcc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin qkc || die
	dodoc qkc.doc
	doman qkc.1
}
