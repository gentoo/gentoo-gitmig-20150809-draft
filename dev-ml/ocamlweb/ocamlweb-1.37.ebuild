# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlweb/ocamlweb-1.37.ebuild,v 1.10 2011/10/05 19:11:58 aballier Exp $

inherit latex-package eutils

DESCRIPTION="O'Caml literate programming tool"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlweb/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlweb/${P}.tar.gz"

IUSE=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

DEPEND=">=dev-lang/ocaml-3.09
	virtual/latex-base
	dev-texlive/texlive-latexextra
	"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-tests.patch"
	epatch "${FILESDIR}/${P}-strip.patch"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake UPDATETEX="" prefix="${D}/usr" MANDIR="${D}/usr/share/man" install || die
	dodoc README CHANGES
}
