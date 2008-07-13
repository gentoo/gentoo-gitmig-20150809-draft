# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-expat/ocaml-expat-0.9.1.ebuild,v 1.4 2008/07/13 06:56:01 josejx Exp $

EAPI="1"

inherit findlib eutils

IUSE="doc +ocamlopt test"

DESCRIPTION="OCaml bindings for expat"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"

RDEPEND="dev-libs/expat"

DEPEND="${RDEPEND}
	test? ( dev-ml/ounit )"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~ppc ~x86"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_unpack(){
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-test.patch"
}

src_compile() {
	emake depend || die "make depend failed"
	emake all || die "make failed"
	if use ocamlopt; then
		emake allopt || die "failed to build native code programs"
	fi
}

src_test() {
	emake test || die "bytecode tests failed"
	if use ocamlopt; then
		emake testopt || die "native code tests failed"
	fi
}
src_install() {
	findlib_src_preinst
	emake install || die

	if use doc ; then
		dohtml -r doc/html/*
	fi
	dodoc README
}
