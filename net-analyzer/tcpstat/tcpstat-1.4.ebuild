# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.4.ebuild,v 1.9 2003/09/05 23:40:10 msterret Exp $

IUSE="berkdb"

S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND=">=net-libs/libpcap-0.5.2
	berkdb? ( <sys-libs/db-2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof

	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
