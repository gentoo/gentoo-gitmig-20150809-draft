# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.9-r1.ebuild,v 1.2 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Various utilities dealing with the PCI bus"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz
		ftp://ftp.yggdrasil.com/pub/dist/device_control/pcimodules/pcimodules-pciutils-2.1.8.diff.gz"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# this patch does apply cleanly to pciutils-2.1.9
	# add pcimodules utility
	gunzip -c ${DISTDIR}/pcimodules-pciutils-2.1.8.diff.gz | patch -p1

	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	make PREFIX=/usr lib/config.h || die

	cd ${S}/lib
	cp config.h config.h.orig
	sed -e "s:/usr/share/pci.ids:/usr/share/misc/pci.ids:" config.h.orig > config.h || die

	cd ${S}
	make PREFIX=/usr || die
}

src_install () {
	into /
	dosbin setpci lspci pcimodules
	doman *.8

	insinto /usr/share/misc
	doins pci.ids

	dolib lib/libpci.a

	insinto /usr/include/pci
	doins lib/*.h
}
