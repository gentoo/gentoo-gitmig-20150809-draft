# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/libjconv/libjconv-2.9.ebuild,v 1.6 2004/06/28 01:51:49 vapier Exp $

DESCRIPTION="A library for converting between kanji encodings"
HOMEPAGE="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}"
SRC_URI="http://ghost.math.sci.hokudai.ac.jp/misc/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
IUSE=""
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/libc"

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
