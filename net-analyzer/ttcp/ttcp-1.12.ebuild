# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ttcp/ttcp-1.12.ebuild,v 1.1 2003/12/31 05:39:44 vapier Exp $

inherit gcc

DESCRIPTION="Tool to test TCP and UDP throughput"
HOMEPAGE="http://ftp.arl.mil/~mike/ttcp.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o ttcp sgi-ttcp.c || die "compile failed"
}

src_install() {
	dobin ttcp
	newman sgi-ttcp.1 ttcp.1
}
