#Copyright 2002 Gentoo Technologies, Inc.
#Distributed under the terms of the GNU General Public License v2 
#$Header: /var/cvsroot/gentoo-x86/app-misc/oneko/oneko-1.2.ebuild,v 1.2 2002/07/25 19:18:34 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A cat (or dog) which chases the mouse around the screen"
SRC_URI="http://agtoys.sourceforge.net/oneko/${P}.tar.gz"
HOMEPAGE="http://agtoys.sourceforge.net"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"

DEPEND="x11-base/xfree"

src_compile() {

	xmkmf -a || die
	emake || die
}

src_install () {
	
	into /usr
	dobin oneko
	mv oneko._man oneko.1x
	doman oneko.1x
	dodoc oneko.1x.html oneko.1.html README README-NEW
}
