# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/countrycodes/countrycodes-1.0.5.ebuild,v 1.1 2004/02/29 22:10:15 humpback Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An ISO 3166 country code finder."
HOMEPAGE="http://www.grigna.com/diego/linux/countrycodes/"
KEYWORDS="~x86"
SRC_URI="http://www.grigna.com/diego/linux/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
sys-apps/sed"

src_compile() {
	make -C src $MAKEOPTS CCOPTS="$CFLAGS" || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/man/man1
	make -C src prefix=${D}/usr install || die
	dosym iso3166 /usr/bin/countrycodes
	dodoc doc/Changelog doc/README doc/COPYING doc/INSTALL
}
