# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beep/beep-1.2.2.ebuild,v 1.7 2002/12/15 11:58:45 bjb Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Beep, the advanced PC speaker beeper"
HOMEPAGE="http://www.johnath.com/beep/"
SRC_URI="http://www.johnath.com/beep/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha"

DEPEND="virtual/glibc"

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
