# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.6.1.ebuild,v 1.4 2004/03/07 22:07:59 avenj Exp $

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"
LICENSE="as-is"
KEYWORDS="~x86 amd64"
SLOT="0"
IUSE=""

DEPEND=">=app-text/chasen-2.3.2"

S="${WORKDIR}/${P}"

src_compile() {
	sed -i -e "/^install-data-am:/s/install-data-local//" Makefile.in
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	insinto /etc
	doins chasenrc
	dodoc INSTALL* README NEWS || die
}
