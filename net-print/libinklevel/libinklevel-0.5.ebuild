# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="A library to get the ink level of your printer"
SRC_URI="http://home.arcor.de/markusheinz/${P}.tar.gz"
HOMEPAGE="http://home.arcor.de/markusheinz/libinklevel.html"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="sys-libs/libieee1284"

S=${WORKDIR}/${PN}

src_install () {
	make DESTDIR=${D}/usr install || die
	dodoc COPYING README
}
