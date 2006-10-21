# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kon2/kon2-0.3.9b-r1.ebuild,v 1.12 2006/10/21 00:26:49 flameeyes Exp $

inherit eutils

DESCRIPTION="KON Kanji ON Linux console"
HOMEPAGE="none"
SRC_URI="ftp://ftp.linet.gr.jp/pub/KON/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=">=media-fonts/konfont-0.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-exec.patch"
	epatch "${FILESDIR}/${P}-bufover-fix.patch"
	epatch "${FILESDIR}/${P}-racecondition-fix3.patch"
	epatch "${FILESDIR}/${P}-gcc34.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_compile() {
	make config || die
	make depend || die
	make || die
}

src_install() {
	make LIBDIR="${D}"/etc \
		MANDIR="${D}"/usr/share/man/ja/man1 \
		BINDIR="${D}"/usr/bin install || die

	dodir /usr/share/terminfo
	tic terminfo.kon -o"${D}"/usr/share/terminfo
}
