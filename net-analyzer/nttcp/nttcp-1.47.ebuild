# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nttcp/nttcp-1.47.ebuild,v 1.2 2004/04/08 03:30:56 lv Exp $

inherit gcc

DESCRIPTION="New version of ttcp -- Tool to test TCP and UDP throughput"
HOMEPAGE="http://www.leo.org/~elmar/nttcp/"
SRC_URI="http://www.leo.org/~elmar/nttcp/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64 ~amd64"

DEPEND="virtual/glibc"

src_compile() {
	emake ARCH= CC="${CC}" OPT="${CFLAGS}" || die "build failed"
}

src_install() {
	dobin nttcp
	doman nttcp.1
}
