# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtkhx/gtkhx-0.9.4.ebuild,v 1.6 2004/06/25 00:33:36 agriffis Exp $


DESCRIPTION="a GTK+ Hotline Client based off of Hx"
SRC_URI="http://gtkhx.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://gtkhx.sourceforge.net/index.html"

DEPEND="=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ppc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die
	dohtml -r doc
	dodoc COPYING ChangeLog INSTALL README TODO
}
