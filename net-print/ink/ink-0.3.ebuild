# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/ink/ink-0.3.ebuild,v 1.7 2005/02/04 23:37:11 cryos Exp $

DESCRIPTION="A command line utility to display the ink level of your printer"
SRC_URI="mirror://sourceforge/ink/${P}.tar.gz"
HOMEPAGE="http://ink.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 amd64"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=net-print/libinklevel-0.6"

S=${WORKDIR}/${PN}

src_install () {
	make DESTDIR=${D}/usr install || die
	dodoc COPYING README
}
