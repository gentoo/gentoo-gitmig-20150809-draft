# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/smet2html/smet2html-0.1.ebuild,v 1.3 2004/06/02 13:56:39 squinky86 Exp $

DESCRIPTION="Convert eDonkey2000 server.met to html"
HOMEPAGE="http://ed2k-tools.sourceforge.net/${PN}.shtml"
SRC_URI="mirror://sourceforge/ed2k-tools/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e "s:gcc -Wall:gcc ${CFLAGS} -Wall:g" ${S}/Makefile
}

src_compile() {
	make || die "make failed"
}

src_install() {
	dobin smet2html
}
