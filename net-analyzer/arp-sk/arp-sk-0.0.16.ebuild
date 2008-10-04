# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arp-sk/arp-sk-0.0.16.ebuild,v 1.5 2008/10/04 00:54:09 darkside Exp $

DESCRIPTION="A swiss knife tool for ARP"
HOMEPAGE="http://sid.rstack.org/arp-sk/"
SRC_URI="http://sid.rstack.org/arp-sk/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
DEPEND=">=net-libs/libnet-1.1"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# We don't need libcompat as it has a potential to clash with other packages.
	rm -fr ${D}/usr/lib

	dodoc ARP AUTHORS CONTRIB ChangeLog README TODO
}

src_compile() {
	econf || die
	emake || die
}
