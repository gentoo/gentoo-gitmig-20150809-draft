# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-0.20.ebuild,v 1.4 2003/07/13 11:30:14 aliz Exp $

DESCRIPTION="A Tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://www.circlemud.org/~jelson/software/tcpflow/"
SRC_URI="http://www.circlemud.org/pub/jelson/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"

RDEPEND="net-libs/libpcap"

src_compile() {
	econf || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	einstall
	doman tcpflow.1
	dodoc AUTHORS COPYING ChangeLog NEWS README
}

