# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/newlfm/newlfm-8.3.ebuild,v 1.2 2004/12/28 21:15:42 absinthe Exp $

inherit latex-package

DESCRIPTION="Extensive LaTeX class for writing letters"
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/newlfm.html"
# Downloaded from:
# ftp://ftp.dante.de/tex-archive/macros/latex/contrib/newlfm.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="virtual/tetex"
S="${WORKDIR}/${PN}"

src_compile() {
	latex newlfm.ins || die
}

src_install() {

	insinto /usr/share/texmf/tex/latex/newlfm
	doins *.sty *.cls letrinfo.tex

	insinto /usr/share/doc/${PF}/tests
	doins test* extracd.tex letrx.tex lvb.* palm.* wine.*

	dodoc manual.pdf README README.uploads
}
