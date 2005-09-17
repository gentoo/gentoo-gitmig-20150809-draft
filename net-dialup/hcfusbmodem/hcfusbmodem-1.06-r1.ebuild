# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hcfusbmodem/hcfusbmodem-1.06-r1.ebuild,v 1.1 2005/09/17 09:20:52 mrness Exp $

inherit linux-info eutils

DESCRIPTION="hcfusbmodem - Modem driver for Connexant HSF chipset"
SRC_URI="http://www.linuxant.com/drivers/hcf/full/archive/${P}powerpcfull.tar.gz"
HOMEPAGE="http://www.linuxant.com/drivers/"

IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="~ppc"
DEPEND="virtual/libc"

S="${WORKDIR}/${P}powerpcfull"

src_unpack() {
	unpack ${A}

	if kernel_is ge 2 6 11 ; then
		epatch ${FILESDIR}/${P}-USB_byteorder.patch
		if kernel_is ge 2 6 13 ; then
			epatch ${FILESDIR}/${P}-simple_class.patch
		fi
	fi
}

src_compile() {
	emake all || die
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HCF modem,"
	einfo "please run hcfusbconfig."
}
