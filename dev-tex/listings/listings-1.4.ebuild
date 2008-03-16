# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/listings/listings-1.4.ebuild,v 1.6 2008/03/16 14:49:49 coldwind Exp $

inherit latex-package

DESCRIPTION="A source code and pretty print package for LaTeX"
# Taken from ctan:
# http://www.tex.ac.uk/tex-archive/macros/latex/contrib/listings.zip
SRC_URI="mirror://gentoo/${P}.zip"
HOMEPAGE="http://www.tex.ac.uk/tex-archive/macros/latex/contrib/listings/"
LICENSE="LPPL-1.3"

IUSE="doc"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
DEPEND="app-arch/unzip"

S=${WORKDIR}/${PN}
TEXMF="/usr/share/texmf-site"

DOCS="README"

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	emake listings || die "Failed to create listings.sty"
	if use doc; then
		emake -j1 all || die "Failed to create documentation"
	fi
}

src_install() {
	export VARTEXFONTS="${T}/fonts"
	latex-package_src_install
}
