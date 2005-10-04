# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-0.21.ebuild,v 1.5 2005/10/04 20:12:03 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="A Tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://www.circlemud.org/~jelson/software/tcpflow/"
SRC_URI="http://www.circlemud.org/pub/jelson/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
IUSE=""

DEPEND="virtual/libpcap"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die
	emake CC=$(tc-getCC) || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog NEWS README
}
