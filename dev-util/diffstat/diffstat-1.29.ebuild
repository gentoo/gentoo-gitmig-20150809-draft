# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.29.ebuild,v 1.10 2003/10/30 12:34:39 brandy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="diffstat reads the output of diff and displays a histogram of the insertions, deletions, and modifications per-file"
SRC_URI="ftp://invisible-island.net/${PN}/${PN}.tar.gz"
HOMEPAGE="http://dickey.his.com/diffstat/diffstat.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"

DEPEND="sys-apps/diffutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-hard-locale.patch
}

src_compile() {
	econf || die
	export CFLAGS="-Wshadow -Wconversion -Wstrict-prototypes -Wmissing-prototypes ${CFLAGS}"
	make || die
}

src_install() {
	dobin diffstat
	doman diffstat.1
	dodoc README CHANGES
}
