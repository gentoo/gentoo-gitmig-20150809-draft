# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.5.2-r1.ebuild,v 1.8 2008/10/27 20:15:23 jer Exp $

inherit eutils toolchain-funcs

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-implicit.patch
}

src_compile() {
	tc-export CC

	econf || die "econf failed"
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog KEYS NEWS README TODO VERSION
}
