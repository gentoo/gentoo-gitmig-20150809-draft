# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-0.9.9.ebuild,v 1.4 2003/03/13 09:57:05 pvdabeel Exp $

A=xmlrpc-c-${PV}.tar.gz
S=${WORKDIR}/xmlrpc-c-${PV}
DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${A}"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

IUSE=""
DEPEND="virtual/glibc
	net-libs/libwww"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/gentoo-${PV}.patch || die
}

src_install() {
	make prefix=${D}/usr install
}
