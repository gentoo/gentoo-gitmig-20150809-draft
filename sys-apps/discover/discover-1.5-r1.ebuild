# (C) 2002 The TelemetryBox Corporation. http://telemetrybox.biz
# Distributed under the terms of the GNU General Public License v2
# Christoph Lameter, <christoph@lameter.com>, July 15, 2002
# $Header: /var/cvsroot/gentoo-x86/sys-apps/discover/discover-1.5-r1.ebuild,v 1.6 2003/06/21 21:19:39 drobbins Exp $

DESCRIPTION="Discover hardware and load the appropriate drivers for that hardware."
HOMEPAGE="http://hackers.progeny.com/discover/"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/discover/${PN}_${PV}-1.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
DEPEND="sys-apps/tar sys-apps/gzip"
RDEPEND="sys-apps/discover-data"

S=${WORKDIR}/${P}

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
