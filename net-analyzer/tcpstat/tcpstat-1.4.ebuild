# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.4.ebuild,v 1.1 2002/04/27 13:03:42 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2
	berkdb? ( <sys-libs/db-2 )"

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof
	  
	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
