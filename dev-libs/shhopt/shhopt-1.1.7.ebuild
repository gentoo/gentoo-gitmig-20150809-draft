# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shhopt/shhopt-1.1.7.ebuild,v 1.3 2004/10/05 13:26:58 pvdabeel Exp $

DESCRIPTION="library for parsing command line options"
SRC_URI="http://shh.thathost.com/pub-unix/files/${P}.tar.gz"
HOMEPAGE="http://shh.thathost.com/pub-unix/"
LICENSE="Artistic"
DEPEND=""
IUSE=""
SLOT="0"
KEYWORDS="ppc"

src_compile() {
	emake || die
}

src_install () {
	dolib.a libshhopt.a
	dodoc ChangeLog CREDITS INSTALL README TODO
}
