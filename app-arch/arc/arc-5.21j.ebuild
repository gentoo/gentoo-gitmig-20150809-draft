# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/arc/arc-5.21j.ebuild,v 1.7 2004/06/04 23:17:48 dholm Exp $

inherit gcc

DESCRIPTION="Create & extract files from DOS .ARC files."
HOMEPAGE="http://arc.sourceforge.net/"
SRC_URI="mirror://sourceforge/arc/${P}.tar.gz"

KEYWORDS="x86 ~alpha amd64 sparc ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CC=$(gcc-getCC) OPT="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin arc marc || die "dobin failed"
	doman arc.1
}
