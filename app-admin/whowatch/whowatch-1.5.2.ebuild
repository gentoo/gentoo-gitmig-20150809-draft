# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2.ebuild,v 1.21 2004/06/24 21:43:00 agriffis Exp $

inherit eutils

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	econf || die "econf failed"
	make || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog KEYS NEWS README TODO VERSION
}
