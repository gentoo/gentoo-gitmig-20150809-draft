# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.6.0.ebuild,v 1.3 2003/10/01 09:44:33 aliz Exp $

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

DEPEND="app-text/chasen"

S="${WORKDIR}/${P}"

src_compile() {
	sed -i -e "/^install-data-am:/s/install-data-local//" Makefile.in
	econf || die
	make || die
}

src_install () {
	einstall DESTDIR=${D} || die
	insinto /etc
	doins chasenrc
	dodoc INSTALL* README NEWS || die
}
