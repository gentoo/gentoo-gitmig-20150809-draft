# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.5.ebuild,v 1.8 2005/07/19 16:35:21 dholm Exp $

IUSE="berkdb"

DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND="virtual/libpcap
	berkdb? ( <sys-libs/db-2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 sparc x86"

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof

	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
