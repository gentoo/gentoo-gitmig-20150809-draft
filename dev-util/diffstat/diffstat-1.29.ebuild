# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke
# $Header: /var/cvsroot/gentoo-x86/dev-util/diffstat/diffstat-1.29.ebuild,v 1.1 2001/11/28 04:16:02 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="diffstat reads the output of diff and displays a histogram of the insertions, deletions, and modifications per-file"
SRC_URI="ftp://invisible-island.net/diffstat/diffstat.tar.gz"
HOMEPAGE="http://dickey.his.com/diffstat/diffstat.html"
DEPEND="sys-apps/diffutils"

src_compile() {                           
	./configure --prefix=/usr --host="${CHOST}"
	assert

	make CFLAGS="-Wshadow -Wconversion -Wstrict-prototypes -Wmissing-prototypes ${CFLAGS}" || die
}

src_install() {                               
	dobin diffstat
	doman diffstat.1
	dodoc README CHANGES
}
