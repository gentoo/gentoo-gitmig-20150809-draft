# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtex2html/bibtex2html-1.96.ebuild,v 1.3 2011/07/23 11:25:58 maekke Exp $

EAPI=2

inherit eutils

IUSE="doc +ocamlopt"

DESCRIPTION="A bibtex to HTML converter"
SRC_URI="http://www.lri.fr/~filliatr/ftp/bibtex2html/${P}.tar.gz"
HOMEPAGE="http://www.lri.fr/~filliatr/bibtex2html/"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
RESTRICT="test"

# With use doc we need a latex compiler to generate manual.pdf
# hevea is used for manual.html
# manual.tex needs fullpage.sty
DEPEND=">=dev-lang/ocaml-3.10[ocamlopt?]
	doc? ( virtual/latex-base
	|| ( dev-texlive/texlive-latexextra app-text/ptex )
		dev-tex/hevea )"
# We need tex-base for bibtex but also some bibtex styles, so we use latex-base
RDEPEND="virtual/latex-base"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.88-destdir.patch"
	# Avoid pre-stripped files
	sed -i -e "s/strip/true/" Makefile.in
	# Fix build with ocaml 3.12, bug #331081
	has_version '>=dev-lang/ocaml-3.12' && sed -i 's/lstr/lcamlstr/' Makefile.in
	# For make install
	use ocamlopt || sed -i 's/= opt /= noopt /' Makefile.in
}

src_compile() {
	export VARTEXFONTS="${T}/fonts"
	if use ocamlopt ; then
		emake opt || die
	else
		emake byte || die
	fi
	if use doc; then
		emake doc || die "failed to create doc"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "failed to install"
	dodoc README CHANGES
	if use doc; then
		dodoc manual.pdf
		dohtml manual.html
	fi
}
