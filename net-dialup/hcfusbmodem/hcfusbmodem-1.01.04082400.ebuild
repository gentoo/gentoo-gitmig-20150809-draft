# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfusbmodem/hcfusbmodem-1.01.04082400.ebuild,v 1.1 2004/11/07 12:23:08 mrness Exp $

MY_P=${P%.*}lnxt${PV##*.}powerpcfull
S=${WORKDIR}/${MY_P}
DESCRIPTION="hcfusbmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.linuxant.com/drivers/hcf/full/archive/${MY_P}.tar.gz"
HOMEPAGE="http://www.linuxant.com/drivers/"
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
