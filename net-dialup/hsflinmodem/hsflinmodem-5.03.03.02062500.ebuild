# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsflinmodem/hsflinmodem-5.03.03.02062500.ebuild,v 1.2 2002/07/17 10:43:24 seemant Exp $

S=${WORKDIR}/${PN}-5.03.03.L3mbsibeta02062500
DESCRIPTION="hsflinmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.mbsi.ca/cnxtlindrv/hsf/hsflinmodem-5.03.03.L3mbsibeta02062500/dl/${PN}-5.03.03.L3mbsibeta02062500.tar.gz"
HOMEPAGE="http://www.mbsi.ca/cnxtlindrv/"
DEPEND=""
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="Conexant"
KEYWORDS="x86"


src_compile() {
	emake all || die
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die
}

pkg_postinst() {
	echo "To complete the installation and configuration of your HSF modem,"
	echo "please run hsfconfig."
}
