# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmbatppc/wmbatppc-1.0-r1.ebuild,v 1.1 2002/08/30 07:44:13 seemant Exp $

S=${WORKDIR}/wmbatppc
DESCRIPTION="wmbatppc is a small battery-monitoring dockapp. It works on G3/G4 Powerbooks and iBooks."
SRC_URI="http://titelou.free.fr/wmbatppc/${P}.tar.gz"
HOMEPAGE="http://titelou.free.fr/wmbatppc/"

DEPEND="virtual/x11
	sys-apps/pmud"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="ppc"

src_compile() {
	make || die 
}

src_install () {
	dodir /usr/bin/
	dobin wmbatppc
	doman wmbatppc.1
}
