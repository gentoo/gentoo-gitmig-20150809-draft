# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-5.15.0.ebuild,v 1.7 2009/06/21 12:16:14 aballier Exp $

EAPI="1"

inherit findlib eutils

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

RDEPEND=">=dev-lang/ocaml-3.07
	>=dev-libs/libpcre-4.5"
DEPEND="${RDEPEND}"
SLOT="0"
IUSE="examples +ocamlopt"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

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
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
