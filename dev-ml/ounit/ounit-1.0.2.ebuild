# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-1.0.2.ebuild,v 1.3 2008/04/09 17:25:58 nixnut Exp $

inherit findlib eutils

EAPI="1"

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
DEPEND="dev-lang/ocaml"
IUSE="+ocamlopt"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	emake all || die "emake failed"
	if use ocamlopt; then
		emake allopt || die "failed to build native code"
	fi
}

src_install() {
	findlib_src_install

	# install documentation
	dodoc README changelog
}
