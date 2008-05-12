# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-5.15.0.ebuild,v 1.1 2008/05/12 07:00:08 aballier Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.07
	>=dev-libs/libpcre-4.5"
SLOT="0"
IUSE="examples +ocamlopt"
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
	emake byte-code-library || die "Failed to build byte code library"
	if use ocamlopt; then
		emake native-code-library || die "Failed to build native code library"
	fi
}

src_install () {
	export OCAMLFIND_INSTFLAGS="-optional"
	findlib_src_install

	# install documentation
	dodoc README VERSION Changes

	if use examples; then
		for dir in examples/*
		do
		  docinto $dir
		  dodoc $dir/*
		done
	fi
}
