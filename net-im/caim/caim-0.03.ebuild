# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/caim/caim-0.03.ebuild,v 1.10 2004/11/09 22:24:59 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A Console AIM Client"
SRC_URI="http://www.mercyground.co.uk/${P}.tar.gz"
HOMEPAGE="http://www.mercyground.co.uk"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.1"

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
