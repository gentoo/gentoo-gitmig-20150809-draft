# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/open_c-lit/open_c-lit-1.4.ebuild,v 1.2 2004/09/06 22:41:00 vapier Exp $

MY_PV=${PV//.}
DESCRIPTION="Open Convert .LIT tool"
HOMEPAGE="http://www.kyz.uklinux.net/convlit.php"
SRC_URI="http://www.kyz.uklinux.net/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="fetch"

DEPEND=""

S=${WORKDIR}/clit${MY_PV}src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "/^CFLAGS=/s:-O2:${CFLAGS}:" */Makefile
}
				
src_compile() {
	cd ${S}/lib
	emake || die
	cd ${S}/clit${MY_PV}
	emake || die
}

src_install() {
	dodoc README
	cd clit${MY_PV}
	dobin clit || die "dobin failed"
	dodoc BUGS CHANGES
}
