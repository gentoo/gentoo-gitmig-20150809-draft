# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pqiv/pqiv-0.2.ebuild,v 1.1 2007/06/19 13:59:33 drac Exp $

DESCRIPTION="PyGTK+ rewrite of Quick Image Viewer"
HOMEPAGE="http://www.pberndt.com/Programme/Linux/pqiv"
SRC_URI="http://www.pberndt.com/raw/Programme/Linux/${PN}/_download/${P}.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk"
DEPEND=""

src_install() {
	newbin pqiv.py qiv
	doman qiv.1
	dodoc README
}
