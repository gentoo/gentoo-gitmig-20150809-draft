# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtex2html/bibtex2html-1.88.ebuild,v 1.2 2007/12/08 10:11:00 aballier Exp $

inherit eutils

IUSE="doc"

DESCRIPTION="A bibtex to HTML converter"
SRC_URI="http://www.lri.fr/~filliatr/ftp/bibtex2html/${P}.tar.gz"
HOMEPAGE="http://www.lri.fr/~filliatr/bibtex2html/"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
RESTRICT="test"

RDEPEND=">=dev-lang/ocaml-3.09"
# With use doc we need a latex compile to generate manual.ps
# hevea is used for manual.html
# manual.tex needs fullpage.sty
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base
	|| ( dev-texlive/texlive-latexextra app-text/tetex app-text/ptex )
		dev-tex/hevea )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-destdir.patch"
	# Avoid pre-stripped files
	sed -i -e "s/strip/true/" Makefile.in
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	econf || die "could not configure bibtex2html"
	emake || die "could not make bibtex2html"
	if use doc; then
		emake doc || die "failed to create doc"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	dodoc README CHANGES
	if use doc; then
		dodoc manual.ps
		dohtml manual.html
	fi
}
