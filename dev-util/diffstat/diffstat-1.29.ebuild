# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.29.ebuild,v 1.8 2003/09/06 08:39:20 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="diffstat reads the output of diff and displays a histogram of the insertions, deletions, and modifications per-file"
SRC_URI="ftp://invisible-island.net/${PN}/${PN}.tar.gz"
HOMEPAGE="http://dickey.his.com/diffstat/diffstat.html"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc "

DEPEND="sys-apps/diffutils"

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
