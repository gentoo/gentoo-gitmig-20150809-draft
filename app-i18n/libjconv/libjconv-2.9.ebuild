# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libjconv/libjconv-2.9.ebuild,v 1.3 2003/06/29 22:12:04 aliz Exp $

DESCRIPTION="A library for converting between kanji encodings"
SRC_URI="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}/${P}.tar.gz"
HOMEPAGE="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}"

LICENSE="LGPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dodir /usr/include
	insinto /usr/include
	doins jconv.h

	dolib libjconv.so
	( cd ${D}/usr/lib ; chmod 755 libjconv.so )
	dolib libjconv.a

	dobin jconv
	dodir /etc/libjconv
	insinto /etc/libjconv
	doins default.conf
	dodoc README.old
	dodoc libjconv.html
}
