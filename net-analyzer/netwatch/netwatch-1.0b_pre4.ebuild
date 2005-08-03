# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwatch/netwatch-1.0b_pre4.ebuild,v 1.2 2005/08/03 10:11:13 eradicator Exp $

MY_P=${P/_pre4/play}
S="${WORKDIR}/${MY_P}"

SRC_URI="http://www.slctech.org/~mackay/${MY_P}.src.tgz"
DESCRIPTION="a ncurses based network monitoring program"
HOMEPAGE="http://www.slctech.org/~mackay/netwatch.html"

LICENSE="GPL-2"
KEYWORDS="-amd64 ~ppc ~x86"
IUSE=""
SLOT="0"

RDEPEND="sys-libs/ncurses"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4.0.7"

src_unpack() {
	unpack ${A}
	sed -i "s:<sys/time.h>:<sys/time.h>\n#include <time.h>:" "${S}/netwatch.c"
}

src_install() {
	exeinto /usr/sbin
	doexe netwatch netresolv
	doman netwatch.1
	dodoc BUGS CHANGES COPYING README README.performance TODO
}
