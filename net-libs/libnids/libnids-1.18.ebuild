# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.18.ebuild,v 1.6 2005/01/29 21:19:57 dragonheart Exp $

inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://www.packetfactory.net/Projects/libnids/"
SRC_URI="http://www.packetfactory.net/Projects/libnids/dist/${P/_}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="virtual/libpcap
	>=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libnids-1.18-chksum.c-ebx.patch
}

src_compile() {
	econf --enable-shared || die
	make || die
}

src_install() {
	einstall install_prefix=${D} || die
	mkdir -p ${D}/usr/include/ ${D}/usr/share/man/man3/
	cp -dpR ${D}/${D}/* ${D}/
	rm -rf ${D}/${D} ${D}/var
	dodoc CHANGES COPYING CREDITS MISC README
}
