# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/fcpci/fcpci-03.10.02.ebuild,v 1.4 2004/07/14 22:40:47 agriffis Exp $

DESCRIPTION="CAPI4Linux drivers for AVM Fritz!Card PCI"
HOMEPAGE="http://www.avm.de/"
S="${WORKDIR}/fritz"
SRC_URI="ftp://ftp.avm.de/cardware/fritzcrd.pci/linux/suse.81/fcpci-suse8.1-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/linux-sources"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 <${FILESDIR}/tools.c.diff
	krnlver=`uname -r`
	mv src.drv/makefile src.drv/makefile.orig
	cat src.drv/makefile.orig | sed -e "s/\`uname -r\`/${krnlver}/" \
		-e 's/-DMODULE/-DMODULE -DMODVERSIONS/' \
		-e "s:(DEFINES) -O2:(DEFINES) ${CFLAGS} -include /lib/modules/${krnlver}/build/include/linux/modversions.h:" \
		>src.drv/makefile
}

src_compile() {
	emake || die "compile problem"
}

src_install () {
	insinto /lib/modules/`uname -r`/misc
	doins src.drv/fcpci.o
	dodoc CAPI* compile* license.txt
	dohtml install_passive-d.html
}
