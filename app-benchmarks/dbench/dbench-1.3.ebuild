# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-1.3.ebuild,v 1.10 2004/03/12 11:18:08 mr_bones_ Exp $

S="${WORKDIR}/${PN}"
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
	sed -i -e "s:-O2 -Wall:${CFLAGS}:g" Makefile
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
