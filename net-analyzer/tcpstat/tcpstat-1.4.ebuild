# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.4.ebuild,v 1.13 2005/01/31 14:24:27 dragonheart Exp $

IUSE="berkdb"

DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND="virtual/libpcap
	berkdb? ( <sys-libs/db-2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof

	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
