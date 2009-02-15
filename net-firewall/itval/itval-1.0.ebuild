# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/itval/itval-1.0.ebuild,v 1.2 2009/02/15 20:41:23 loki_val Exp $

inherit eutils flag-o-matic

DESCRIPTION="Iptables policy testing and validation tool"
HOMEPAGE="http://itval.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/ITVal-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/bison
	sys-devel/flex"

S=${WORKDIR}/ITVal-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_install(){
	make DESTDIR="${D}" install || die "make install failed"
	doman itval.n
	dodoc README ChangeLog RELEASE AUTHORS
}
