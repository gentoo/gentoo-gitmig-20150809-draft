# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-2.0.ebuild,v 1.3 2002/08/14 08:43:07 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="ftp://samba.org/pub/tridge/dbench/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2 -Wall:${CFLAGS}:g" Makefile.orig > Makefile
}

src_compile() {
	emake
}

src_install() {
	dobin dbench tbench tbench_srv
	dodoc README results.txt
	insinto /usr/share/dbench
	doins client_plain.txt client_oplocks.txt
	doman dbench.1
}

pkg_postinst() {
	einfo "dbench info:"
	einfo "You can find the client_*.txt file in ${ROOT}usr/share/dbench."
	echo
}
