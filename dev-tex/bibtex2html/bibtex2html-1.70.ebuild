# Copyright 1999-2004 Gentoo Foundations
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/bibtex2html/bibtex2html-1.70.ebuild,v 1.2 2004/08/28 18:12:18 dholm Exp $

inherit fixheadtails

IUSE=""

DESCRIPTION="A bibtex to HTML converter"
SRC_URI="http://www.lri.fr/~filliatr/ftp/bibtex2html/${P}.tar.gz"
HOMEPAGE="http://www.lri.fr/~filliatr/bibtex2html/"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.07"

src_compile() {
	ht_fix_file configure*
	econf --prefix=/usr || die "could not configure bibtex2html"
	emake || die "could not make bibtex2html"
}

src_install() {
	dobin aux2bib bib2bib bibtex2html
	doman aux2bib.1 bib2bib.1 bibtex2html.1
}
