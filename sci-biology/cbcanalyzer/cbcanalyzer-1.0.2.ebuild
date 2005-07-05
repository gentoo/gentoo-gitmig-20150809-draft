# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/cbcanalyzer/cbcanalyzer-1.0.2.ebuild,v 1.2 2005/07/05 09:54:40 dholm Exp $

DESCRIPTION="Creates phylogenetic trees measuring compensatory base changes"
HOMEPAGE="http://www.biozentrum.uni-wuerzburg.de/index.php?id=524"
SRC_URI="http://www.biozentrum.uni-wuerzburg.de/fileadmin/user_upload/bioinformatik/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~x86"
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

