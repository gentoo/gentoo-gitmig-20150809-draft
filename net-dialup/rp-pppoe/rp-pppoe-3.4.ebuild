# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.4.ebuild,v 1.3 2002/07/17 10:43:25 seemant Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${P}.tar.gz"
HOMEPAGE="http://www.roaringpeguin.com/"

DEPEND=">=net-dialup/ppp-2.4.1"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

src_compile() {

	econf || die
	make || die

}

src_install () {

	make RPM_INSTALL_ROOT=${D} install || die
	dodir /usr/share/doc
	mv ${D}/usr/doc/${P} ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/doc
	prepalldocs

}

