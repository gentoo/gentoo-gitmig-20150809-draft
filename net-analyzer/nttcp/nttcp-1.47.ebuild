# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nttcp/nttcp-1.47.ebuild,v 1.3 2004/06/19 05:05:47 vapier Exp $

inherit gcc

DESCRIPTION="tool to test TCP and UDP throughput"
HOMEPAGE="http://www.leo.org/~elmar/nttcp/"
SRC_URI="http://www.leo.org/~elmar/nttcp/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~alpha ~amd64 ~ia64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake ARCH= CC="$(gcc-getCC)" OPT="${CFLAGS}" || die "build failed"
}

src_install() {
	dobin nttcp || die
	doman nttcp.1
}
