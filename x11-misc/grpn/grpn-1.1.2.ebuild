# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grpn/grpn-1.1.2.ebuild,v 1.4 2004/02/28 19:19:17 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GRPN is a Reverse Polish Notation calculator for X"
HOMEPAGE="http://lashwhip.com/grpn.html"
SRC_URI="http://lashwhip.com/grpn/${P}.tar.gz"

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa"

src_compile() {
	emake || die
}

src_install () {
	dobin grpn
	doman grpn.1
	dodoc CHANGES README
}
