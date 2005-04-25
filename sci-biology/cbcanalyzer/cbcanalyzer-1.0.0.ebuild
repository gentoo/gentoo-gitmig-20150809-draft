# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/cbcanalyzer/cbcanalyzer-1.0.0.ebuild,v 1.1 2005/04/25 19:46:25 apokorny Exp $

DESCRIPTION="Creates phylogenetic trees measuring compensatory base changes"
HOMEPAGE="http://cbcanalyzer.bioapps.biozentrum.uni-wuerzburg.de/"
SRC_URI="http://cbcanalyzer.bioapps.biozentrum.uni-wuerzburg.de/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4.2
	>=dev-libs/boost-1.32-r1"


# cbcanalyzer works with wxGTK-2.4/wxGTK-2.5 gtk1 gtk2
# but only the non unicode versions

src_install() {
	make install DESTDIR=${D} || die
}

pkg_postinst() {
	einfo
	einfo "To visualize trees you might want to install sci-biology/njplot"
	einfo "and sci-biology/treeviewx."
	einfo
}

