# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/beep/beep-1.2.2.ebuild,v 1.2 2002/07/25 16:55:21 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Beep, the advanced PC speaker beeper"
HOMEPAGE="http://www.johnath.com/beep"
SRC_URI="http://www.johnath.com/beep/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=""
RDEPEND=""

src_compile() {
	emake || die "compile problem"
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1

	exeinto /usr/bin
	doexe beep

	insinto /usr/share/man/man1
	doins beep.1.gz

	dodoc CHANGELOG COPYING CREDITS README
}
