# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/europecv/europecv-20060123-r1.ebuild,v 1.1 2006/04/20 19:33:09 ehmsen Exp $

inherit latex-package

DESCRIPTION="LaTeX class for the standard model for curricula vitae as recommended by the European Commission."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/europecv.html"
# Downloaded from:
# ftp://cam.ctan.org/tex-archive/macros/latex/contrib/europecv.zip
SRC_URI="mirror://gentoo/${PF}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE=""

RDEPEND="virtual/tetex"
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}/${PN}"

src_compile() {
	return
}

src_install() {
	insinto /usr/share/texmf/tex/latex/europecv
	doins ecv* europecv.cls EuropeFlag* europasslogo*

	insinto /usr/share/doc/${PF}
	doins -r examples templates europecv.pdf europecv.tex
}
