# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.17_rc1.ebuild,v 1.4 2004/07/15 00:56:11 agriffis Exp $

inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.0-r3"

S=${WORKDIR}/${P/_rc1}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libnids_gcc33_fix
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc CHANGES COPYING CREDITS MISC README
}
