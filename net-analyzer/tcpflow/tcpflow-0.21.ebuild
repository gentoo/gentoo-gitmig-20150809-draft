# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpflow/tcpflow-0.21.ebuild,v 1.1 2005/01/26 00:44:09 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="A Tool for monitoring, capturing and storing TCP connections flows"
HOMEPAGE="http://www.circlemud.org/~jelson/software/tcpflow/"
SRC_URI="http://www.circlemud.org/pub/jelson/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

RDEPEND="net-libs/libpcap"

src_compile() {
	econf || die
	emake CC=$(tc-getCC) || die
}

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog NEWS README
}

