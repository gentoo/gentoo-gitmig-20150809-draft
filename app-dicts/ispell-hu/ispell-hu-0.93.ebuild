# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-hu/ispell-hu-0.93.ebuild,v 1.1 2004/04/04 17:49:03 liquidx Exp $

S="${WORKDIR}/magyarispell-${PV}"
DESCRIPTION="Hungarian dictionary for Ispell"
SRC_URI="http://www.szofi.hu/gnu/magyarispell/magyarispell-${PV}.tar.gz"
HOMEPAGE="http://www.szofi.hu/gnu/magyarispell"

SLOT="0"
LICENSE="GPL-2"
DEPEND="app-text/ispell"
KEYWORDS="~x86"

src_compile() {
	emake all || die
}

src_install () {
	dodir /usr/lib/ispell
	dodir /usr/bin
	make DESTDIR=${D} install || die

	dodoc ChangeLog COPYING README GYIK
}
