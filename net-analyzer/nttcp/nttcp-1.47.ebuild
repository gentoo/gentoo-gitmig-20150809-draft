# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nttcp/nttcp-1.47.ebuild,v 1.9 2005/07/19 15:32:25 dholm Exp $

inherit toolchain-funcs

DESCRIPTION="tool to test TCP and UDP throughput"
HOMEPAGE="http://www.leo.org/~elmar/nttcp/"
SRC_URI="http://www.leo.org/~elmar/nttcp/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ~ppc x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	emake ARCH= CC="$(tc-getCC)" OPT="${CFLAGS}" || die "build failed"
}

src_install() {
	dobin nttcp || die
	doman nttcp.1
}
