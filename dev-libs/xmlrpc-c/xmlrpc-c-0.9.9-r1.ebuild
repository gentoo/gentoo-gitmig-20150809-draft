# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-0.9.9-r1.ebuild,v 1.1 2004/08/16 19:58:58 pvdabeel Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tar.gz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="x86 ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	net-libs/libwww"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-${PV}-r1.patch
}

src_install() {
	make prefix=${D}/usr install || die
}
