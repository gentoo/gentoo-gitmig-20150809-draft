# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnids/libnids-1.20.ebuild,v 1.3 2005/06/27 18:29:35 vanquirius Exp $

inherit eutils

DESCRIPTION="emulates the IP stack of Linux 2.0.x and offers IP defragmentation, TCP stream assembly and TCP port scan detection."
HOMEPAGE="http://sourceforge.net/projects/${PN}/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="~amd64 ~x86 ~ppc ~sparc ~alpha"
IUSE=""

DEPEND="virtual/libpcap
	>=net-libs/libnet-1.1.0-r3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-chksum.c-ebx.patch
}

src_compile() {
	econf --enable-shared || die "econf failed"
	make || die "emake failed"
}

src_install() {
	make install_prefix="${D}" install || die "make install failed"
	dodoc CHANGES COPYING CREDITS MISC README
}
