# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.1.ebuild,v 1.5 2004/04/16 05:24:03 vapier Exp $ 

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/knock/"
SRC_URI="http://www.zeroflux.org/knock/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
	dohtml doc/index.html

	insinto /etc/conf.d; newins ${FILESDIR}/knockd.confd knock
	exeinto /etc/init.d; newexe ${FILESDIR}/knockd.initd knock
}
