# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-hu/ispell-hu-0.99.4.ebuild,v 1.1 2004/07/15 19:20:13 arj Exp $

MY_P=magyarispell-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hungarian dictionary for Ispell"
SRC_URI="http://magyarispell.sourceforge.net/${MY_P}.tar.gz"
HOMEPAGE="http://magyarispell.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="app-text/ispell"
IUSE=""

src_compile() {
	make ispell || die
}

src_install () {

	insinto /usr/lib/ispell

	doins tmp/magyar.aff
	newins tmp/magyar4ispell.hash magyar.hash
	dosym /usr/lib/ispell/magyar.hash /usr/lib/ispell/hungarian.hash

	dodoc ChangeLog COPYING GYIK README OLVASSEL TODO
}
