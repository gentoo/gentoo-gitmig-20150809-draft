# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/sexplib/sexplib-7.0.5.ebuild,v 1.1 2012/06/30 14:15:29 aballier Exp $

EAPI=3

OASIS_BUILD_DOCS=1
OASIS_BUILD_TESTS=1

inherit oasis

DESCRIPTION="Library for automated conversion of OCaml-values to and from S-expressions"
HOMEPAGE="http://forge.ocamlcore.org/projects/sexplib/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/832/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-ml/type-conv-3.0.5"
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
