# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pqiv/pqiv-0.1.ebuild,v 1.1 2007/05/27 17:16:39 drac Exp $

DESCRIPTION="PyGTK+ rewrite of Quick Image Viewer"
HOMEPAGE="http://www.pberndt.com"
SRC_URI="http://www.pberndt.com/raw/Programme/Linux/pqiv/_download/pqiv-0.1.tbz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-python/pygtk"
DEPEND=""

src_install() {
	newbin pqiv.py qiv
	doman qiv.1
}
