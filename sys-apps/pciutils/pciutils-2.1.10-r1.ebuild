# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.10-r1.ebuild,v 1.12 2004/01/24 18:25:47 plasmaroo Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha hppa arm"

DEPEND="virtual/glibc
	net-misc/wget"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/pcimodules-pciutils-2.1.8.diff

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
