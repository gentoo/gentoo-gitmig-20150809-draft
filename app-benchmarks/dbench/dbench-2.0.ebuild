# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/dbench/dbench-2.0.ebuild,v 1.12 2004/11/29 06:47:36 eradicator Exp $

DESCRIPTION="Popular filesystem benchmark"
SRC_URI="ftp://samba.org/pub/tridge/dbench/${P}.tar.gz"
HOMEPAGE="ftp://samba.org/pub/tridge/dbench/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 ~sparc"
IUSE=""
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
