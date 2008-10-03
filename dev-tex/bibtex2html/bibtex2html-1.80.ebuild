# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtex2html/bibtex2html-1.80.ebuild,v 1.4 2008/10/03 06:29:16 aballier Exp $

inherit fixheadtails

IUSE=""

DESCRIPTION="A bibtex to HTML converter"
SRC_URI="http://www.lri.fr/~filliatr/ftp/bibtex2html/${P}.tar.gz"
HOMEPAGE="http://www.lri.fr/~filliatr/bibtex2html/"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"

DEPEND=">=dev-lang/ocaml-3.07"
# We need tex-base for bibtex but also some bibtex styles, so we use latex-base
RDEPEND="virtual/latex-base"

src_compile() {
	ht_fix_file configure*
	econf --prefix=/usr || die "could not configure bibtex2html"
	emake || die "could not make bibtex2html"
}

src_install() {
	dobin aux2bib bib2bib bibtex2html
	doman aux2bib.1 bib2bib.1 bibtex2html.1
	dodoc README CHANGES
}
