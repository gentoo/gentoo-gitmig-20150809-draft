# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/rp-pppoe/rp-pppoe-3.4-r2.ebuild,v 1.2 2003/02/13 13:55:52 vapier Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="A user-mode PPPoE client and server suite for Linux"
SRC_URI="http://www.roaringpenguin.com/pppoe/${P}.tar.gz"
HOMEPAGE="http://www.roaringpenguin.com/"
DEPEND=">=net-dialup/ppp-2.4.1"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

src_compile() {
	mv configure configure.back
	sed configure.back -e 's/modprobe/#modprobe/' > configure
	chmod a+x configure
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
