# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core/core-0.6.0.ebuild,v 1.2 2010/11/11 20:09:18 aballier Exp $

EAPI="2"
inherit findlib eutils

DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tgz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND=">=dev-lang/ocaml-3.11[ocamlopt]
	dev-ml/res
	dev-ml/sexplib
	dev-ml/bin-prot
	dev-ml/fieldslib
	dev-ml/pcre-ocaml"
DEPEND="${RDEPEND}
	test? (
		dev-ml/ounit
		dev-ml/type-conv
	)"

src_prepare() {
	has_version '>=dev-lang/ocaml-3.12' && epatch "${FILESDIR}/${P}-ocaml312.patch"
}

src_compile() {
	emake -j1 || die
}

src_test() {
	cd "${S}/extended_test"
	ocamlfind ocamlc -package bigarray,oUnit,type-conv,sexplib,bin_prot,res,fieldslib,pcre,threads -thread -dtypes -I ../extended -I ../lib yes.ml -o yes.exe || die
	for i in lib extended ; do
		cd "${S}/${i}_test"
		emake || die
		./test_runner.exe || die
	done
}

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc README
}
