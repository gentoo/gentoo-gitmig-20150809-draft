# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-0.9.9-r1.ebuild,v 1.3 2005/02/17 17:32:30 sekretarz Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tar.gz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="x86 ppc ~amd64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	net-libs/libwww"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gcc-3.4.patch
	epatch ${FILESDIR}/gentoo-${PV}-r1.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
