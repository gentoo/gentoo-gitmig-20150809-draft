# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12.ebuild,v 1.7 2002/08/26 11:11:14 aliz Exp $

MY_P=${PN}-1.4a12
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility to trace the route of IP packets"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz"
HOMEPAGE="http://ee.lbl.gov/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf --sbindir=/usr/bin || die
	emake || die
}

src_install () {
	dodir /usr/bin
	make DESTDIR=${D} install || die

	doman traceroute.8
	dodoc CHANGES INSTALL
}
