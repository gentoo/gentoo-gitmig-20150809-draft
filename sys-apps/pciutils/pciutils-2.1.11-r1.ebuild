# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pciutils/pciutils-2.1.11-r1.ebuild,v 1.3 2004/01/25 05:00:21 brad_mssw Exp $

inherit eutils

DESCRIPTION="Various utilities dealing with the PCI bus"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~mj/pciutils.html"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/linux/pci/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~ia64 ~ppc64 ~amd64"

DEPEND="virtual/glibc
	net-misc/wget"

[ "${ARCH}" = "amd64" ] && append-flags -fPIC

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/pcimodules-${P}.diff
	epatch ${FILESDIR}/${PV}-sysfs.patch #38645

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
	dosbin setpci lspci pcimodules update-pciids
	doman *.8

	insinto /usr/share/misc
	doins pci.ids

	into /usr
	dolib lib/libpci.a

	insinto /usr/include/pci
	doins lib/*.h
}
