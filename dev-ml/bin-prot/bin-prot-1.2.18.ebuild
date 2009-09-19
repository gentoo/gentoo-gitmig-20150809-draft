# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/bin-prot/bin-prot-1.2.18.ebuild,v 1.2 2009/09/19 20:53:37 mr_bones_ Exp $

EAPI="2"

inherit findlib

DESCRIPTION="Automated code generation for converting OCaml values to/from a type-safe binary protocol"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"
S=${WORKDIR}/${P}/lib

RDEPEND=">=dev-lang/ocaml-3.11[ocamlopt]
		dev-ml/type-conv"
DEPEND="${RDEPEND}
		test? ( dev-ml/ounit )
		doc? ( virtual/latex-base )"

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" || die
}

src_test() {
	cd "${S}/../lib_test"
	emake -j1 || die
	./test_runner || die
}

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc ../README.txt ../Changelog
	if use doc; then
		cd ../doc
		pdflatex README.tex
		dodoc README.pdf
	fi
}
