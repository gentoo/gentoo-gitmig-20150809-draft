# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ipadic/ipadic-2.7.0.ebuild,v 1.14 2010/01/01 20:09:10 fauli Exp $

IUSE=""

DESCRIPTION="Japanese dictionary for ChaSen"
HOMEPAGE="http://chasen.aist-nara.ac.jp/chasen/distribution.html.en"
SRC_URI="http://chasen.aist-nara.ac.jp/stable/ipadic/${P}.tar.gz"

LICENSE="ipadic"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"

DEPEND=">=app-text/chasen-2.3.1"

src_compile() {
	sed -i -e "/^install-data-am:/s/install-data-local//" Makefile.in || die
	econf || die
	make || die
}

src_install () {
	make DESTDIR="${D}" install || die

	insinto /etc
	doins chasenrc
	dodoc AUTHORS ChangeLog NEWS README || die
}
