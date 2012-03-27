# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/sexplib/sexplib-7.0.4.ebuild,v 1.2 2012/03/27 21:08:38 aballier Exp $

EAPI=3

inherit oasis

DESCRIPTION="Library for automated conversion of OCaml-values to and from S-expressions"
HOMEPAGE="http://forge.ocamlcore.org/projects/sexplib/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/699/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-ml/type-conv-3.0.4"
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
