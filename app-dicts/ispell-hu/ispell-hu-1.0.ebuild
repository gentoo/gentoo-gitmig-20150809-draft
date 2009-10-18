# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-hu/ispell-hu-1.0.ebuild,v 1.4 2009/10/18 00:59:23 halcy0n Exp $

inherit eutils

MY_P=magyarispell-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Hungarian dictionary for Ispell"
SRC_URI="http://magyarispell.sourceforge.net/${MY_P}.tar.gz"
HOMEPAGE="http://magyarispell.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND="app-text/ispell
	app-text/recode"
IUSE=""

src_compile() {
	epatch "${FILESDIR}/ispell-hu-1.0-fix-build.patch"
	make ispell || die
}

src_install () {

	insinto /usr/lib/ispell

	doins tmp/magyar.aff
	newins tmp/magyar4ispell.hash magyar.hash
	dosym /usr/lib/ispell/magyar.hash /usr/lib/ispell/hungarian.hash

	dodoc ChangeLog GYIK README OLVASSEL
}
