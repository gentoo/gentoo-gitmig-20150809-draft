# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.3.ebuild,v 1.5 2004/07/04 16:29:04 centic Exp $

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=net-print/libinklevel-0.6"

S=${WORKDIR}/${PN}

src_install () {
	make DESTDIR=${D}/usr install || die
	dodoc COPYING README
}
