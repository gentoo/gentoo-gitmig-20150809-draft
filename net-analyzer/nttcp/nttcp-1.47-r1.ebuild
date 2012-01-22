# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nttcp/nttcp-1.47-r1.ebuild,v 1.5 2012/01/22 15:13:04 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="tool to test TCP and UDP throughput"
HOMEPAGE="http://www.leo.org/~elmar/nttcp/"
SRC_URI="http://www.leo.org/~elmar/nttcp/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_compile() {
	emake ARCH= CC="$(tc-getCC)" OPT="${CFLAGS}" LFLAGS="${LDFLAGS}" || die "build failed"
}

src_install() {
	dobin nttcp || die
	doman nttcp.1
}
