# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/achemso/achemso-1.0.ebuild,v 1.8 2007/02/06 16:36:53 nattfodd Exp $

inherit latex-package
S=${WORKDIR}
DESCRIPTION="LaTeX package used for formatting publications to the American Chemical Society"
# mirrored from http://theory.uwinnipeg.ca/scripts/CTAN/macros/latex/contrib/achemso.zip
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/achemso.html"
LICENSE="LPPL-1.2" #custom, LPPL-like
SLOT="0"
IUSE=""
KEYWORDS="x86 alpha ppc ~sparc ~amd64"
DEPEND="app-arch/unzip"
