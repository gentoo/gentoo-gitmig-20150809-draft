# Copyright 1999-2002 Gentoo Technologies, Inc.
# Copyright 2003 Alex Holden <alex@alexholden.net>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gpsim/gpsim-0.20.14.ebuild,v 1.1 2003/06/25 04:15:40 rphillips Exp $

S=${WORKDIR}/${P} 
DESCRIPTION="A simulator for the Microchip PIC microcontrollers" 
SRC_URI="http://www.dattalo.com/gnupic/${P}.tar.gz" 
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="x11-libs/gtk+extra"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gcc3.2.patch
}

src_compile(){ 
 	econf || die
	emake || die
} 
 
src_install() { 
	einstall || die
	dodoc ANNOUNCE AUTHORS COPYING ChangeLog HISTORY INSTALL NEWS PROCESSORS
	dodoc README README.EXAMPLES README.MODULES TODO
}
