# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.4.ebuild,v 1.5 2002/10/04 05:59:39 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND=">=net-libs/libpcap-0.5.2
	berkdb? ( <sys-libs/db-2 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof
	  
	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
