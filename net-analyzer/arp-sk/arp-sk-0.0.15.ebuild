# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arp-sk/arp-sk-0.0.15.ebuild,v 1.3 2004/08/16 10:09:56 eldad Exp $

DESCRIPTION="A swiss knife tool for ARP"
HOMEPAGE="http://www.arp-sk.org/"
SRC_URI="http://www.arp-sk.org/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND=">=net-libs/libnet-1.1"

src_install() {
	make DESTDIR=${D} install || die

	# Don't need this library, and it has a potential to clash with other packages.
	rm ${D}/usr/lib/libcompat.a

	dodoc ARP AUTHORS CONTRIB ChangeLog INSTALL README TODO
}

src_compile() {
	econf || die
	emake || die
}
