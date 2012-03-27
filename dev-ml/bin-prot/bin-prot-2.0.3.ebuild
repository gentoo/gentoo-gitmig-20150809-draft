# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bin-prot/bin-prot-2.0.3.ebuild,v 1.3 2012/03/27 21:29:02 aballier Exp $

EAPI=3

inherit oasis

DESCRIPTION="A binary protocol generator"
HOMEPAGE="http://ocaml.janestreet.com/?q=node/13"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=">=dev-ml/ounit-1.0.2
	>=dev-ml/type-conv-2.3.0"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base dev-texlive/texlive-latexextra )"

DOCS=( "README.txt" "Changelog" )

src_compile() {
	oasis_src_compile
	if use doc ; then
		cd "${S}/doc"
		pdflatex README || die
		pdflatex README || die
	fi
}

src_install() {
	oasis_src_install

	if use doc; then
		dodoc doc/README.pdf || die
	fi
}
