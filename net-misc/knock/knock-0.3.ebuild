# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.3.ebuild,v 1.13 2006/02/20 21:17:24 jokey Exp $

inherit eutils

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/knock/"
SRC_URI="http://www.zeroflux.org/knock/${P}.tar.gz"

DEPEND="net-libs/libpcap"

KEYWORDS="x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/nonblock.patch
	epatch ${FILESDIR}/knockd.conf.patch
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
	dohtml doc/index.html

	newconfd ${FILESDIR}/knockd.confd knock
	newinitd ${FILESDIR}/knockd.initd knock
}
