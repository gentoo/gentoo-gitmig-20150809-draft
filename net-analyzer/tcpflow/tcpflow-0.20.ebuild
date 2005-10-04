# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-0.20.ebuild,v 1.8 2005/10/04 20:12:03 swegener Exp $

DESCRIPTION="A Tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://www.circlemud.org/~jelson/software/tcpflow/"
SRC_URI="http://www.circlemud.org/pub/jelson/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND="virtual/libpcap"
RDEPEND="${DEPEND}"

src_install() {
	einstall
	doman tcpflow.1
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
