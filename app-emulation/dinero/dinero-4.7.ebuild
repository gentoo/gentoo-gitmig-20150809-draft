# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dinero/dinero-4.7.ebuild,v 1.4 2004/03/02 21:07:37 dholm Exp $

IUSE=""

HOMEPAGE="http://www.cs.wisc.edu/~markhill/DineroIV/"
SRC_URI="ftp://ftp.cs.wisc.edu/markhill/DineroIV/d4-7.tar.gz"
DESCRIPTION="Cache simulator"
SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="as-is"
P=${P/inero-/}
P=${P/./-}
S=${WORKDIR}/${P}



src_compile() {
	econf
	emake
}

src_install() {
	dodoc CHANGES COPYTRIGHT NOTES README TODO

	dobin dineroIV
}
