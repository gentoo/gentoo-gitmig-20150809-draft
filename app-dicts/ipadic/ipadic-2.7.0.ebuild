# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.7.0.ebuild,v 1.1 2004/04/18 05:14:35 matsuu Exp $

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
SLOT="0"
IUSE=""

DEPEND=">=app-text/chasen-2.3.1"

src_compile() {
	sed -i -e "/^install-data-am:/s/install-data-local//" Makefile.in || die
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	insinto /etc
	doins chasenrc
	dodoc AUTHORS ChangeLog INSTALL* NEWS README || die
}
