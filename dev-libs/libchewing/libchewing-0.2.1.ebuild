# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libchewing/libchewing-0.2.1.ebuild,v 1.4 2004/06/24 23:14:26 agriffis Exp $

inherit flag-o-matic

IUSE=""
DESCRIPTION="Library for Chinese Phonetic input method"
HOMEPAGE="http://jserv.sayya.org/wiki/index.php/Qooing"
SRC_URI="http://jserv.sayya.org/qooing/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/glibc"

src_compile() {
	append-flags -I./include
	emake CFLAGS="${CFLAGS}" -j1 || die
}

src_install() {
	dodir /usr/lib
	make install PREFIX=${D}/usr || die
}
