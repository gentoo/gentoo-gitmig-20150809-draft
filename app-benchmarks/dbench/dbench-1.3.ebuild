# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-1.3.ebuild,v 1.4 2002/07/16 02:40:35 owen Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="ftp://samba.org/pub/tridge/dbench/"
DEPEND="virtual/glibc sys-apps/sed"

KEYWORDS="x86 ppc"
SLOT=0
LICENSE="GPL-2"

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
	dodoc README
	insinto /usr/share/dbench
	doins client.txt
}

pkg_postinst() {
	einfo "dbench info:"
	einfo "You can find the client.txt file in ${ROOT}usr/share/dbench."
}
