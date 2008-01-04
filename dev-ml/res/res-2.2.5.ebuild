# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/res/res-2.2.5.ebuild,v 1.2 2008/01/04 07:18:42 mr_bones_ Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="Resizable Array and Buffer modules for O'Caml"
HOMEPAGE="http://ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.07"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc examples +ocamlopt"

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

	if use doc; then
		emake htdoc || die "failed to build documentation"
	fi
}

src_install () {
	use ocamlopt || export OCAMLFIND_INSTFLAGS="-optional"
	findlib_src_install

	# install documentation
	dodoc README TODO VERSION Changes

	if use doc; then
		dohtml lib/doc/res/html/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
