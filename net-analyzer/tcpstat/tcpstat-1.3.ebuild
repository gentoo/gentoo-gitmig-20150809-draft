# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpstat/tcpstat-1.3.ebuild,v 1.7 2002/07/11 06:30:45 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Reports network interface statistics"
SRC_URI="http://www.frenchfries.net/paul/tcpstat/${P}.tar.gz"
HOMEPAGE="http://www.frenchfries.net/paul/tcpstat/"

DEPEND="virtual/glibc
	>=net-libs/libpcap-0.5.2
	berkdb? ( <sys-libs/db-2 )"

src_compile() {

	econf || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	use berkdb && dobin src/tcpprof
	  
	dodoc AUTHORS ChangeLog COPYING LICENSE NEWS README*

}
