# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dinero/dinero-4.7.ebuild,v 1.2 2003/06/29 20:06:54 aliz Exp $

IUSE=""

HOMEPAGE="http://www.cs.wisc.edu/~markhill/DineroIV/"
SRC_URI="ftp://ftp.cs.wisc.edu/markhill/DineroIV/d4-7.tar.gz"
DESCRIPTION="Cache simulator"
SLOT="0"
KEYWORDS="x86"
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
