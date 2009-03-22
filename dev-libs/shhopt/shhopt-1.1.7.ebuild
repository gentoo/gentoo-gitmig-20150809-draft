# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/shhopt/shhopt-1.1.7.ebuild,v 1.6 2009/03/22 12:43:03 jmbsvicetto Exp $

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
	emake || die
}

src_install () {
	dolib.a libshhopt.a
	dodoc ChangeLog CREDITS INSTALL README TODO
}
