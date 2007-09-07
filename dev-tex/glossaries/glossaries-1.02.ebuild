# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/glossaries/glossaries-1.02.ebuild,v 1.2 2007/09/07 12:08:42 angelos Exp $

inherit latex-package

DESCRIPTION="Create glossaries and lists of acronyms."
HOMEPAGE="http://www.ctan.org/tex-archive/help/Catalogue/entries/glossaries.html"
SRC_URI="ftp://tug.ctan.org/tex-archive/macros/latex/contrib/${PN}.zip"

LICENSE="LPPL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-lang/perl
	>=dev-tex/xkeyval-2.5f"

TEXMF="/usr/share/texmf-site"
S=${WORKDIR}/${PN}

src_install() {
	latex-package_src_doinstall styles

	dobin scripts/makeglossaries

	dodoc CHANGES README
	if use doc ; then
		cd ${S}/doc
		latex-package_src_doinstall pdf
		dodoc *.tex
	fi
}
