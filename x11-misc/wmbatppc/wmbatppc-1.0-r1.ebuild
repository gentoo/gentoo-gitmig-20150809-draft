# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmbatppc/wmbatppc-1.0-r1.ebuild,v 1.2 2002/07/08 21:31:07 aliz Exp $

S=${WORKDIR}/wmbatppc

DESCRIPTION="wmbatppc is a small battery-monitoring dockapp. It works on G3/G4 Powerbooks and iBooks."
SRC_URI="http://titelou.free.fr/wmbatppc/${P}.tar.gz"
HOMEPAGE="http://titelou.free.fr/wmbatppc/"
DEPEND="virtual/glibc x11-base/xfree sys-apps/pmud"
RDEPEND="virtual/glibc x11-base/xfree sys-apps/pmud"
SLOT=1
LICENSE=GPL-2
KEYWORDS="ppc"

src_compile() {
	make || die 
}

src_install () {
	dodir /usr/bin/
	dobin wmbatppc
	doman wmbatppc.1
}
