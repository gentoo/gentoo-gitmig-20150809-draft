# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/lineno/lineno-3.10-r1.ebuild,v 1.3 2007/02/06 17:00:47 nattfodd Exp $

inherit latex-package
S=${WORKDIR}/${PN}
DESCRIPTION="LaTeX package used for automatically numbering lines of a document"
# Taken from http://theory.uwinnipeg.ca/scripts/CTAN/macros/latex/contrib/lineno.zip
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/lineno.html"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="!>=app-text/tetex-3.0"
