# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2.ebuild,v 1.13 2002/12/09 04:17:36 manson Exp $

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time."
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	econf
	make || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog COPYING KEYS NEWS README TODO VERSION
}
