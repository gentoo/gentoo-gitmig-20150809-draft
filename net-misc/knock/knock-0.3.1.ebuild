# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knock/knock-0.3.1.ebuild,v 1.3 2004/11/01 19:27:48 vapier Exp $

inherit eutils

DESCRIPTION="A simple port-knocking daemon"
HOMEPAGE="http://www.zeroflux.org/knock/"
SRC_URI="http://www.zeroflux.org/knock/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-libs/libpcap-0.8.3-r1"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/knockd.conf.patch
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README
	dohtml doc/index.html

	newinitd ${FILESDIR}/knockd.initd knock
	newconfd ${FILESDIR}/knockd.confd knock
}
