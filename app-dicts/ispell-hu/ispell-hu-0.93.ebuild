# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-hu/ispell-hu-0.93.ebuild,v 1.4 2005/01/01 12:54:32 eradicator Exp $

DESCRIPTION="Hungarian dictionary for Ispell"
HOMEPAGE="http://www.szofi.hu/gnu/magyarispell"
SRC_URI="http://www.szofi.hu/gnu/magyarispell/magyarispell-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-text/ispell"

S="${WORKDIR}/magyarispell-${PV}"

src_compile() {
	emake all || die
}

src_install() {
	dodir /usr/lib/ispell
	dodir /usr/bin
	make DESTDIR=${D} install || die

	dodoc ChangeLog README GYIK
}
