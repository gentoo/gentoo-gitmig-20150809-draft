# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm4400/bcm4400-3.0.7.ebuild,v 1.2 2003/12/23 13:46:25 genone Exp $

SRC_URI="http://www.broadcom.com/docs/driver_download/440x/linux-3.0.7.zip"
DESCRIPTION="Driver for the bcm4400 10/100 network card (in the form of kernel modules)."
HOMEPAGE="http://www.broadcom.com"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"

DEPEND="app-arch/unzip"

S=${WORKDIR}/linux/${P}/src

src_unpack() {

	unpack ${A}
	cd ${WORKDIR}/linux
	tar -xzpf ${P}.tar.gz

}

src_compile() {

	check_KV

	sed -i -e "s|\$(shell uname -r)|$KV|" -e "s|shell uname -r|echo $KV|" Makefile
	emake || die

}

src_install() {

	mkdir -p ${D}/usr/share/man/man4
	make PREFIX=${D} install || die

}

pkg_postinst() {

	echo ">>> Updating module dependencies..."
	/sbin/depmod -a >/dev/null 2>&1

}
