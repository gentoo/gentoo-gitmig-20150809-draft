# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover-data/discover-data-1.2002.05.23-r1.ebuild,v 1.15 2004/08/24 02:58:07 swegener Exp $

inherit eutils

S=${WORKDIR}/discover-data-${P}-1
DESCRIPTION="data for discover. list of pci ids. pnp ids etc."
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="mirror://debian/pool/main/d/discover-data/${PN}_${PV}-1.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc -sparc ~alpha ~hppa ~mips "
IUSE=""

DEPEND="app-arch/tar app-arch/gzip"

src_compile() {
	epatch ${FILESDIR}/kernel-2.2-2.4.drivername.patch
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}
