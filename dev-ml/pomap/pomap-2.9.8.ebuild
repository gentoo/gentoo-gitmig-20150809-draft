# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pomap/pomap-2.9.8.ebuild,v 1.1 2008/01/04 01:51:11 aballier Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="Partially Ordered Map ADT for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ocaml-3.06"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples +ocamlopt"

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
	findlib_src_install

	# install documentation
	dodoc README VERSION Changes

	#install examples
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
