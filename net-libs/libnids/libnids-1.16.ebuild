# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.16.ebuild,v 1.16 2004/07/15 00:56:11 agriffis Exp $

inherit eutils

DESCRIPTION="Libnids is an implementation of an E-component of Network Intrusion Detection System. It emulates the IP stack of Linux 2.0.x. Libnids offers IP defragmentation, TCP stream assembly and TCP port scan detection."
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P}.tar.gz"
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"

DEPEND="net-libs/libpcap
	=net-libs/libnet-1.0*"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc sparc ~alpha"
IUSE=""

src_unpack () {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libnids_gcc33_fix
}

src_compile() {
	econf || die
	make || die
}

src_install () {

	make prefix=${D}/usr mandir=${D}/usr/share/man install

	dodoc CHANGES COPYING CREDITS MISC README

}
