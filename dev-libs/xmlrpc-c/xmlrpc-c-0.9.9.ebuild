# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-0.9.9.ebuild,v 1.5 2003/04/25 15:26:31 vapier Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tar.gz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	net-libs/libwww"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/gentoo-${PV}.patch
}

src_install() {
	make prefix=${D}/usr install || die
}
