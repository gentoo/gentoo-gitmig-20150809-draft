# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttcp/ttcp-1.12.ebuild,v 1.5 2004/06/17 10:42:15 kloeri Exp $

inherit gcc eutils

DESCRIPTION="Tool to test TCP and UDP throughput"
HOMEPAGE="http://ftp.arl.mil/~mike/ttcp.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}
	use amd64 && epatch ${FILESDIR}/ttcp-1.12-amd64.patch
}

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o ttcp sgi-ttcp.c || die "compile failed"
}

src_install() {
	dobin ttcp
	newman sgi-ttcp.1 ttcp.1
}
