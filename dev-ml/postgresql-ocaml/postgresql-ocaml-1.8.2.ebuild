# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/postgresql-ocaml/postgresql-ocaml-1.8.2.ebuild,v 1.2 2008/05/21 16:00:23 dev-zero Exp $

inherit findlib eutils

EAPI="1"

IUSE="examples +ocamlopt"

DESCRIPTION="A package for ocaml that provides access to PostgreSQL databases."
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.bz2"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html#toc9"

DEPEND=">=dev-lang/ocaml-3.09
	>=virtual/postgresql-server-7.3"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	cd "${S}/lib"
	emake -j1 byte-code-library || die "failed to build byte code library"
	if use ocamlopt; then
		emake -j1 native-code-library || die "failed to built nativde code library"
	fi
}

src_install () {
	use ocamlopt || export OCAMLFIND_INSTFLAGS="-optional"
	findlib_src_preinst
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS VERSION

	if use examples; then
		for dir in examples/*
		do
		  docinto $dir
		  dodoc $dir/*
		done
	fi
}
