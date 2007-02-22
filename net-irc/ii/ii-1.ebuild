# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ii/ii-1.ebuild,v 1.1 2007/02/22 12:29:29 armin76 Exp $

DESCRIPTION="A minimalist FIFO and filesystem-based IRC client"
HOMEPAGE="http://www.suckless.org/wiki/tools/irc"
SRC_URI="http://suckless.org/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ii
	dodoc README FAQ
	doman *.1
}
