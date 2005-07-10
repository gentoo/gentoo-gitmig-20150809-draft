# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtkhx/gtkhx-0.9.3.ebuild,v 1.12 2005/07/10 20:03:31 swegener Exp $

DESCRIPTION="a GTK+ Hotline Client based off of Hx"
SRC_URI="http://gtkhx.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://gtkhx.sourceforge.net/index.html"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_install () {

	einstall || die
	dohtml -r doc
	dodoc doc/AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
