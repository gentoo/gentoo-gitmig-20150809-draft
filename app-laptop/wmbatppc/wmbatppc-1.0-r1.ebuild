# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/wmbatppc/wmbatppc-1.0-r1.ebuild,v 1.4 2004/06/28 02:38:16 vapier Exp $

DESCRIPTION="small battery-monitoring dockapp for G3/G4 laptops"
HOMEPAGE="http://titelou.free.fr/wmbatppc/"
SRC_URI="http://titelou.free.fr/wmbatppc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="-* ppc"
IUSE=""

DEPEND="virtual/x11
	app-laptop/pmud"

S=${WORKDIR}/wmbatppc

src_compile() {
	make || die
}

src_install() {
	dobin wmbatppc || die
	doman wmbatppc.1
}
