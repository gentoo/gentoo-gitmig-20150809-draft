# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/quotchap/quotchap-0.9f.ebuild,v 1.6 2007/02/06 17:01:46 nattfodd Exp $

inherit latex-package
S=${WORKDIR}/quotchap
DESCRIPTION="LaTeX package used to add quotes to chapters"
# Taken from http://theory.uwinnipeg.ca/scripts/CTAN/macros/latex/contrib/quotchap.zip
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="ftp://ftp.dante.de/tex-archive/help/Catalogue/entries/quotchap.html"
LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

src_install () {
			addwrite /var/cache/fonts
	        latex-package_src_doinstall all
	        cd ${S}
	        dodoc 00readme.txt document.pdf document.tex
}

