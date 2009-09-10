# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/fasttree/fasttree-2.0.1.ebuild,v 1.1 2009/09/10 23:14:22 weaver Exp $

EAPI="2"

DESCRIPTION="Fast inference of approximately-maximum-likelihood phylogenetic trees"
HOMEPAGE="http://www.microbesonline.org/fasttree/"
#SRC_URI="http://www.microbesonline.org/fasttree/FastTree.c"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

src_install() {
	dobin FastTree FastTreeUPGMA || die
	insinto /usr/share/${PN}
	doins *.pl *.pm || die
	dodoc README*
}
