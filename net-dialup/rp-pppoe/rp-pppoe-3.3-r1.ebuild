# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.3-r1.ebuild,v 1.1 2002/09/27 09:26:16 seemant Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${P}.tar.gz"
HOMEPAGE="http://www.roaringpeguin.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=net-dialup/ppp-2.4.1"

src_compile() {

	econf || die
	make || die
}

src_install () {

	if use tcltk
	then
		cd ../gui
		make RPM_INSTALL_ROOT=${D} install || die
	fi
	
	cd ${S}
	make RPM_INSTALL_ROOT=${D} install || die

	dodir /usr/share/doc
	mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc
	prepalldocs
}
