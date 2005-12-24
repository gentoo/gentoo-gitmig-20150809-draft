# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bact/bact-0.13.ebuild,v 1.1 2005/12/24 18:58:09 usata Exp $

DESCRIPTION="Boosting Algorithm for Classification of Trees"
HOMEPAGE="http://chasen.org/~taku/software/bact/"
SRC_URI="http://chasen.org/~taku/software/bact/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

src_test() {
	make test || die
}

src_install() {
	dobin bact_learn bact_mkmodel bact_classify || die

	dohtml index.html bact.css
	dodoc README AUTHORS
}
