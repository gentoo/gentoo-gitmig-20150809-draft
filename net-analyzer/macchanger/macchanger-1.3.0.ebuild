# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/macchanger/macchanger-1.3.0.ebuild,v 1.7 2004/10/04 23:01:20 pvdabeel Exp $

DESCRIPTION="Utility for viewing/manipulating the MAC address of network interfaces"
SRC_URI="http://savannah.nongnu.org/download/macc/${PN}.pkg/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/macchanger"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"
SLOT="0"

DEPEND="virtual/libc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
