# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrace/tcptrace-6.4.0.ebuild,v 1.1 2003/05/04 19:40:45 aliz Exp $

IUSE=""

DESCRIPTION="A Tool for analyzing network packet dumps"
HOMEPAGE="http://www.tcptrace.org/"
SRC_URI="http://www.tcptrace.org/download/${P}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
DEPEND="net-libs/libpcap"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin tcptrace
	newman tcptrace.man tcptrace.1
#	doman tcptrace.1
	dodoc CHANGES COPYING COPYRIGHT FAQ INSTALL README* THANKS WWW
}

