# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover/discover-1.5-r1.ebuild,v 1.14 2004/07/15 01:44:05 agriffis Exp $

DESCRIPTION="Discover hardware and load the appropriate drivers for that hardware."
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover/${PN}_${PV}-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 -sparc"
IUSE=""
DEPEND="app-arch/tar app-arch/gzip"
RDEPEND="sys-apps/discover-data"

src_compile() {
	econf --sbindir=/sbin || die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	cp ${FILESDIR}/etc-init.d-discover ${D}/etc/init.d/discover
	insinto /usr/share/discover
	doins discover/linuxrc
	dodoc BUGS AUTHORS ChangeLog NEWS README TODO ChangeLog.mandrake docs/ISA-Structure docs/PCI-Structure docs/Programming
	dodir /var/lib/discover
	prepallman
}
