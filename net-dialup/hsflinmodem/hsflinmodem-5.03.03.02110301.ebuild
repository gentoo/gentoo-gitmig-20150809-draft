# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsflinmodem/hsflinmodem-5.03.03.02110301.ebuild,v 1.2 2003/02/13 13:53:20 vapier Exp $

MY_PV=5.03.03.L3mbsibeta02110301
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="hsflinmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.mbsi.ca/cnxtlindrv/hsf/archive/${MY_P}/${MY_P}.tar.gz"
HOMEPAGE="http://www.mbsi.ca/cnxtlindrv/"
DEPEND="virtual/glibc"
IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="~x86"

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
