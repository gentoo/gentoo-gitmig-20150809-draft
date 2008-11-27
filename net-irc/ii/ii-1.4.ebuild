# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ii/ii-1.4.ebuild,v 1.1 2008/11/27 09:59:06 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="A minimalist FIFO and filesystem-based IRC client"
HOMEPAGE="http://www.suckless.org/programs/ii.html"
SRC_URI="http://code.suckless.org/dl/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS      = -g -O0/CFLAGS += -g/" \
		-e "s/LDFLAGS     =/LDFLAGS +=/" \
		config.mk || die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin ii
	dodoc README FAQ
	doman *.1
}
