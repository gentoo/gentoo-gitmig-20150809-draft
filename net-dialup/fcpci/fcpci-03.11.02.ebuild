# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcpci/fcpci-03.11.02.ebuild,v 1.1 2004/04/10 12:22:48 lanius Exp $

inherit flag-o-matic kernel-mod

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"
S="${WORKDIR}/fritz"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.82/fcpci-suse8.2-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/linux-sources"

pkg_setup() {
	kernel-mod_is_2_4_kernel || die "This module is only compatible with 2.4.x kernels."
}

src_unpack() {
	filter-flags "-fstack-protector"
	filter-flags "-fstack-protector-all"

	unpack ${A}
	cd ${S}
	sed -i -e "s/\`uname -r\`/${KV_VERSION_FULL}/" \
		-e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
		-e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -include /lib/modules/${KV_VERSION_FULL}/build/include/linux/modversions.h:" src.drv/makefile
}

src_install () {
	insinto /lib/modules/${KV_VERSION_FULL}/misc
	doins src.drv/fcpci.o
	dodoc CAPI* compile* license.txt
	dohtml install_passive-d.html
}
