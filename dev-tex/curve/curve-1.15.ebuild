# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/curve/curve-1.15.ebuild,v 1.2 2011/06/27 14:11:55 aballier Exp $

EAPI=2

inherit latex-package

S=${WORKDIR}/${PN}

DESCRIPTION="LaTeX style for a CV (curriculum vitae) with flavour option"
SRC_URI="ftp://tug.ctan.org/pub/tex-archive/macros/latex/contrib/${PN}.zip -> ${P}.zip"
HOMEPAGE="http://www.ctan.org/tex-archive/macros/latex/contrib/curve/"
LICENSE="LPPL-1.2"
RDEPEND=""
DEPEND="app-arch/unzip"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

TEXMF=/usr/share/texmf-site

src_install() {

	latex-package_src_doinstall styles

	dodoc *.tex *.pdf README NEWS

}
