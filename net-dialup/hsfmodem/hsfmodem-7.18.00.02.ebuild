# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/hsfmodem/hsfmodem-7.18.00.02.ebuild,v 1.1 2005/01/04 19:30:08 mrness Exp $

DESCRIPTION="Linuxant's modem driver for Connexant HSF chipset"
HOMEPAGE="http://www.linuxant.com/drivers/hsf/index.php"
SRC_URI="x86? ( http://www.linuxant.com/drivers/hsf/full/archive/${P}full/${P}full.tar.gz )
	amd64? ( http://www.linuxant.com/drivers/hsf/full/archive/${P}x86_64full/${P}x86_64full.tar.gz )"

DEPEND="virtual/libc"
IUSE=""
SLOT="0"
LICENSE="Conexant"
KEYWORDS="-* ~x86 ~amd64"

S="${WORKDIR}"

pkg_setup() {
	if useq x86; then
		MY_ARCH_S=${S}/${P}full
	elif useq amd64; then
		MY_ARCH_S=${S}/${P}X86_64full
	fi
}

src_compile() {
	cd ${MY_ARCH_S}
	emake all || die "make failed"
}

src_install () {
	cd ${MY_ARCH_S}
	make PREFIX=${D}/usr/ ROOT=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "To complete the installation and configuration of your HSF modem,"
	einfo "please run hsfconfig."
}
