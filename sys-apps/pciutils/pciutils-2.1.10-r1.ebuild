# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.10-r1.ebuild,v 1.2 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Various utilities dealing with the PCI bus"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	net-misc/wget"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
#	gunzip -c ${DISTDIR}/pcimodules-pciutils-2.1.8.diff.gz >> ${S}/pcimodules-pciutils-2.1.8.diff
	cd ${S}

	patch -p1 -l < ${FILESDIR}/pcimodules-pciutils-2.1.8.diff

#	patch -p0 < ${FILESDIR}/${P}-pcimodules.patch

	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" -e "s:-Werror::g" Makefile.orig > Makefile

	make update-ids

	if [ ! -f pci.ids ] ; then mv pci.ids.orig pci.ids ; fi
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
