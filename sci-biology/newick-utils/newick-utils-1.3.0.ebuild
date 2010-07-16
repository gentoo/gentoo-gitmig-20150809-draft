# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/newick-utils/newick-utils-1.3.0.ebuild,v 1.3 2010/07/16 21:58:30 hwoarang Exp $

EAPI="2"

DESCRIPTION="Tools for processing phylogenetic trees (re-root, subtrees, trimming, pruning, condensing, drawing)"
HOMEPAGE="http://cegg.unige.ch/newick_utils"
SRC_URI="http://cegg.unige.ch/pub/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND=""
RDEPEND=""

src_install() {
	einstall || die
}

src_test() {
	emake -C tests check-TESTS || die
}
