# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gpsim/gpsim-0.20.14.ebuild,v 1.2 2004/03/23 18:16:29 dragonheart Exp $

inherit eutils

DESCRIPTION="A simulator for the Microchip PIC microcontrollers"
HOMEPAGE="http://www.dattalo.com/gnupic/gpsim.html"
SRC_URI="http://www.dattalo.com/gnupic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="x11-libs/gtk+extra"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.2.patch
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
