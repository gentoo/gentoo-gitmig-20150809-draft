# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsfmodem/hsfmodem-6.03.00.04111200.ebuild,v 1.1 2005/01/04 18:43:31 mrness Exp $

MY_P=hsfmodem-${PV%.*}lnxt${PV##*.}full
S=${WORKDIR}/${MY_P}
DESCRIPTION="Linuxant's modem driver for Connexant HSF chipset"
SRC_URI="http://www.linuxant.com/drivers/hsf/full/archive/${MY_P}/${MY_P}.tar.gz"
HOMEPAGE="http://www.linuxant.com/drivers/hsf/index.html"
DEPEND="virtual/libc"
IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="-* x86"

src_compile() {
	emake all || die
}

src_install () {
	make PREFIX=${D}/usr/ ROOT=${D} install || die
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HSF modem,"
	einfo "please run hsfconfig."
}
