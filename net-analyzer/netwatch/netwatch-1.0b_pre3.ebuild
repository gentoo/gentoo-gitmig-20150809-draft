# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwatch/netwatch-1.0b_pre3.ebuild,v 1.1 2004/04/14 09:43:36 eradicator Exp $

MY_P="${P/_pre/.pre}"
SRC_URI="http://www.slctech.org/~mackay/${MY_P}.src.tgz"
DESCRIPTION="a ncurses based network monitoring program"
HOMEPAGE="http://www.slctech.org/~mackay/netwatch.html"

LICENSE="GPL-2"
# Bus errors on sparc at first net traffic
KEYWORDS="~x86 -sparc"
IUSE=""
SLOT="0"

DEPEND="sys-libs/ncurses
	>=sys-apps/sed-4.0.7"

S=${WORKDIR}/${P/_pre*/}

src_unpack() {
	unpack ${A}
	sed -i "s:<sys/time.h>:<sys/time.h>\n#include <time.h>:" "${S}/netwatch.c"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	exeinto /usr/sbin
	doexe netwatch netresolv
	doman netwatch.1
	dodoc BUGS CHANGES COPYING README README.performance TODO
}
