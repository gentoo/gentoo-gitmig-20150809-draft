# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceroute/traceroute-1.4_p12.ebuild,v 1.5 2002/08/14 10:47:39 pvdabeel Exp $

MY_P=${PN}-1.4a12
S=${WORKDIR}/${MY_P}
DESCRIPTION="Utility to trace the route of IP packets"
SRC_URI="ftp://ee.lbl.gov/${MY_P}.tar.gz"
HOMEPAGE="http://ee.lbl.gov/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"

src_install () {
	cd ${S}
	dodir /usr/sbin
	make prefix=${D}/usr install || die

	doman traceroute.8
	dodoc CHANGES INSTALL
}
