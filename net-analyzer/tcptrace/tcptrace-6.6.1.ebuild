# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcptrace/tcptrace-6.6.1.ebuild,v 1.8 2006/02/17 16:17:22 jokey Exp $

inherit gnuconfig

IUSE=""

DESCRIPTION="A Tool for analyzing network packet dumps"
HOMEPAGE="http://www.tcptrace.org/"
SRC_URI="http://www.tcptrace.org/download/${P}.tar.gz
	http://www.tcptrace.org/download/old/6.6/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ppc64"

DEPEND="net-libs/libpcap"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	dobin tcptrace
	newman tcptrace.man tcptrace.1
	dodoc CHANGES COPYING COPYRIGHT FAQ INSTALL README* THANKS WWW
}
