# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/sexplib/sexplib-4.2.17.ebuild,v 1.1 2010/01/03 15:09:12 aballier Exp $

EAPI="2"

inherit findlib

DESCRIPTION="Library for automated conversion of OCaml-values to and from S-expressions"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://ocaml.info/ocaml_sources/${PN}310-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S=${WORKDIR}/${PN}310-${PV}/lib

DEPEND=">=dev-lang/ocaml-3.10[ocamlopt]
	dev-ml/type-conv"
RDEPEND="${DEPEND}"

src_compile() {
	emake -j1 || die
}

src_test() {
	cd "${S}/../lib_test"
	emake -j1 || die
	./conv_test || die
	./sexp_test < test.sexp || die
}

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc ../README.txt ../Changelog
}
