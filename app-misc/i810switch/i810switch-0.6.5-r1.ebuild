# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/i810switch/i810switch-0.6.5-r1.ebuild,v 1.1 2006/10/23 21:57:04 twp Exp $

DESCRIPTION="A utility for switching the LCD and external VGA displays on and off"
HOMEPAGE="http://www16.plala.or.jp/mano-a-mano/i810switch.html"
SRC_URI="http://www16.plala.or.jp/mano-a-mano/i810switch/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	make clean
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog README TODO
}
