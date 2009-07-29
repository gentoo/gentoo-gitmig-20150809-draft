# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shhopt/shhopt-1.1.7.ebuild,v 1.7 2009/07/29 22:45:23 vostorga Exp $

inherit toolchain-funcs

DESCRIPTION="library for parsing command line options"
SRC_URI="http://shh.thathost.com/pub-unix/files/${P}.tar.gz"
HOMEPAGE="http://shh.thathost.com/pub-unix/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install () {
	dolib.a libshhopt.a
	dodoc ChangeLog CREDITS INSTALL README TODO
}
