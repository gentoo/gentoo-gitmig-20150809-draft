# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfusbmodem/hcfusbmodem-0.98.02090200.ebuild,v 1.3 2004/07/01 22:07:14 eradicator Exp $

MY_PV=0.98mbsibeta02090200ppc
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="hcfusbmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.mbsi.ca/cnxtlindrv/hcf/archive/${MY_P}/${MY_P}.tar.gz"
HOMEPAGE="http://www.mbsi.ca/cnxtlindrv/"
DEPEND="virtual/libc"
IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="~ppc"

src_compile() {
	emake all || die
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die
}

pkg_postinst() {
	echo "To complete the installation and configuration of your HCF modem,"
	echo "please run hcfusbconfig."
}
