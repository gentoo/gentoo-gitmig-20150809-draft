# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-0.21.ebuild,v 1.10 2010/04/17 17:49:08 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="A Tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://www.circlemud.org/~jelson/software/tcpflow/"
SRC_URI="http://www.circlemud.org/pub/jelson/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ~ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
SLOT="0"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	econf || die
	emake CC=$(tc-getCC) || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
