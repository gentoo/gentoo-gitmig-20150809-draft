# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.11-r1.ebuild,v 1.8 2004/04/06 03:15:15 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc sparc ~alpha ~hppa ~ia64 ~ppc64 ~amd64 ppc64 ~mips"

DEPEND="virtual/glibc
	net-misc/wget"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/pcimodules-${P}.diff
	epatch ${FILESDIR}/${PV}-sysfs.patch #38645

	[ "${ARCH}" = "amd64" ] && append-flags -fPIC
	sed -i "s:-O2:${CFLAGS}:" Makefile

	./update-pciids.sh
}

src_compile() {
	make PREFIX=/usr lib/config.h || die

	cd ${S}/lib
	sed -i "s:/usr/share/pci.ids:/usr/share/misc/pci.ids:" config.h || die

	cd ${S}
	make PREFIX=/usr || die

	for i in update-pciids lspci.8 update-pciids.8; do
		sed -i "s:/usr/share/pci.ids:/usr/share/misc/pci.ids:" ${i} || die
	done
}

src_install() {
	into /
	dosbin setpci lspci pcimodules update-pciids || die
	doman *.8

	insinto /usr/share/misc
	doins pci.ids || die

	into /usr
	dolib lib/libpci.a

	insinto /usr/include/pci
	doins lib/*.h
}
