# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cook/cook-1.0.2.ebuild,v 1.1 2003/01/03 06:09:07 satai Exp $

DESCRIPTION="COOK is an embedded language which can be used as a macro preprocessor and for similar text processing."
HOMEPAGE="http://cook.sourceforge.net/"
SRC_URI="mirror://sourceforge/cook/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-libs/glibc"
S="${WORKDIR}/${P}"

src_compile() {
	cd ${S}
	emake
}

src_install() {
	cd ${S}
	dodoc README doc/cook.txt doc/cook.html
	dodir /usr/share/doc/${P}/example
	cd ${S}/test
	insinto /usr/share/doc/${P}/example
	doins pcb.dbdef pcb.dg pcbprol.ps tempsens.pcb
	cd ${S}
	dobin src/cook
}
