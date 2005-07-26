# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-1.2.ebuild,v 1.2 2005/07/26 17:33:14 jhhudso Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tgz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="~x86 ~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
MAKEOPTS="-j1"

DEPEND="virtual/libc
	net-libs/libwww"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-${PV}.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
