# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/europecv/europecv-20050408.ebuild,v 1.1 2005/05/22 11:42:33 usata Exp $

inherit latex-package

DESCRIPTION="LaTeX class for the standard model for curricula vitae as recommended by the European Commission."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/europecv.html"
#Downloaded from:
# ftp://www.ctan.org/tex-archive/macros/latex/contrib/europecv.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

DEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_compile() {

	return
}

src_install() {

	insinto /usr/share/texmf/tex/latex/europecv
	doins ecv* europecv.cls EuropeFlag*

	insinto /usr/share/doc/${PF}/examples
	doins examples/*

	dodoc europecv.pdf
}
