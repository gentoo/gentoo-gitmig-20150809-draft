# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsflinmodem/hsflinmodem-5.03.27.03042700.ebuild,v 1.1 2003/07/04 18:14:53 cretin Exp $

MY_PV=5.03.27lnxtbeta03042700
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="hsflinmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.linuxant.com/drivers/hsf/archive/${MY_P}/${MY_P}.tar.gz"
HOMEPAGE="http://www.linuxant.com/drivers/hsf/index.html"
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
