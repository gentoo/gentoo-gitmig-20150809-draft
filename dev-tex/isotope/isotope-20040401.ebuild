# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/isotope/isotope-20040401.ebuild,v 1.1 2007/05/27 13:59:39 cryos Exp $

inherit latex-package

DESCRIPTION="Typeset isotopes correctly in LaTeX documents"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/isotope.html"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}/${PN}
