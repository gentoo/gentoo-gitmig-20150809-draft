# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/caim/caim-0.03.ebuild,v 1.8 2004/04/14 09:35:57 aliz Exp $

inherit eutils

IUSE=""
DESCRIPTION="A Console AIM Client"
SRC_URI="http://www.mercyground.co.uk/${P}.tar.gz"
HOMEPAGE="http://www.mercyground.co.uk"

DEPEND=">=sys-libs/ncurses-5.1"

SLOT="0"
LICENSE="LGPL-2.1 | GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${P}.tar.gz
	epatch ${FILESDIR}/${PF}-gentoo.diff
	cd ${S}
	echo "CFLAGS += ${CFLAGS}" >> Makefile.rules
}

src_compile() {
	emake || die
}

src_install () {
	dobin client/caim
	dolib libfaim.so
	dodoc README Changes
	docinto libfaim
	dodoc faimdocs/BUGS faimdocs/CHANGES faimdocs/README
}
