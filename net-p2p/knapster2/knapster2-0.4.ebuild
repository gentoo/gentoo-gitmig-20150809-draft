# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/knapster2/knapster2-0.4.ebuild,v 1.12 2004/06/29 00:17:54 carlo Exp $ 

inherit kde

DESCRIPTION="Napster Client for Linux"
SRC_URI="mirror://sourceforge/knapster/${P}.tar.gz"
HOMEPAGE="http://knapster.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

need-kde 3

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gcc3.2.diff || die
}
