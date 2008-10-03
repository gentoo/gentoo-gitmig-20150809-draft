# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtex2html/bibtex2html-1.91.ebuild,v 1.2 2008/10/03 06:29:16 aballier Exp $

inherit eutils

IUSE="doc"

DESCRIPTION="A bibtex to HTML converter"
SRC_URI="http://www.lri.fr/~filliatr/ftp/bibtex2html/${P}.tar.gz"
HOMEPAGE="http://www.lri.fr/~filliatr/bibtex2html/"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
RESTRICT="test"

# With use doc we need a latex compiler to generate manual.ps
# hevea is used for manual.html
# manual.tex needs fullpage.sty
DEPEND=">=dev-lang/ocaml-3.09
	doc? ( virtual/latex-base
	|| ( dev-texlive/texlive-latexextra app-text/tetex app-text/ptex )
		dev-tex/hevea )"
# We need tex-base for bibtex but also some bibtex styles, so we use latex-base
RDEPEND="virtual/latex-base"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.88-destdir.patch"
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
