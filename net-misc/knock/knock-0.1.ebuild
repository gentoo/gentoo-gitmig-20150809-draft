# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.1.ebuild,v 1.4 2004/04/15 23:00:45 pyrania Exp $ 

IUSE=""

DESCRIPTION="port-knock server"
SRC_URI="http://www.zeroflux.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.zeroflux.org/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc COPYING README
	dohtml doc/index.html

	insinto /etc/conf.d; newins ${FILESDIR}/knockd.confd knock
	exeinto /etc/init.d; newexe ${FILESDIR}/knockd.initd knock
}
