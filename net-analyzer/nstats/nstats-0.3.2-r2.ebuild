# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Lukas Beeler <lb-gentoo@projectdream.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nstats/nstats-0.3.2-r2.ebuild,v 1.1 2002/04/14 06:44:48 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Displays statistics about ethernet traffic including protocol breakdown"
SRC_URI="http://reeler.org/nstats/files/${P}.tar.gz"
HOMEPAGE="http://reeler.org/nstats/"

DEPEND="virtual/glibc >=net-libs/libpcap-0.6.2"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -D_GNU_SOURCE" || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING
}
