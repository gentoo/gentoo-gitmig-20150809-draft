# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2.ebuild,v 1.7 2002/07/25 13:48:39 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="an interactive who-like program that displays information
about the users currently logged on to the machine, in real time."
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	econf || die
	make || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING KEYS NEWS README TODO VERSION
}
