# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/donkey/donkey-0.53.3.ebuild,v 1.1 2004/07/05 16:58:54 squinky86 Exp $

DESCRIPTION="Official client for the eDonkey2000 network"
HOMEPAGE="http://www.edonkey2000.com"
SRC_URI="http://download.overnet.com/${P}.tar.gz"
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	einfo "Distributed in binary.  No compilation required."
}

src_install () {
	exeinto /opt/bin
	doexe ${P/-/}
	dosym ${D}/opt/bin/${P/-/} /opt/bin/${PN}
	dodoc README
}
