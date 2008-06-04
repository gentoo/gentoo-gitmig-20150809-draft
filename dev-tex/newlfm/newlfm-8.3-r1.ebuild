# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/newlfm/newlfm-8.3-r1.ebuild,v 1.1 2008/06/04 13:00:48 hkbst Exp $

inherit latex-package

DESCRIPTION="Extensive LaTeX class for writing letters"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/newlfm.html"
# Downloaded from:
# ftp://ftp.dante.de/tex-archive/macros/latex/contrib/newlfm.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_compile() {
	latex newlfm.ins || die
}

src_install() {
	insinto /usr/share/texmf/tex/latex/newlfm
	doins *.sty *.cls letrinfo.tex lvb.* palm.* wine.*

	dosym palm.eps /usr/share/texmf/tex/latex/newlfm/palmb.eps
	dosym palm.pdf /usr/share/texmf/tex/latex/newlfm/palmb.pdf

	insinto /usr/share/doc/${PF}/tests
	doins test* extracd.tex # letrx.tex

	dodoc manual.pdf README # README.uploads
}
