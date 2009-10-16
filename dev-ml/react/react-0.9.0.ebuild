# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/react/react-0.9.0.ebuild,v 1.2 2009/10/16 12:17:03 aballier Exp $

EAPI="2"

DESCRIPTION="OCaml module for functional reactive programming"
HOMEPAGE="http://erratique.ch/software/react"
SRC_URI="http://erratique.ch/software/react/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="+ocamlopt doc"

DEPEND=">=dev-lang/ocaml-3.11[ocamlopt?]"
RDEPEND="${DEPEND}"

src_compile() {
	./build module-byte || die "bytecode failed"
	if use ocamlopt ; then
		./build module-native || die "native code failed"
	fi
	if use doc ; then
		./build doc || die "doc building failed"
	fi
}

src_test() {
	./build test.byte || die
	./test.byte || die
	if use ocamlopt ; then
		./build test.native || die
		./test.native || die
	fi
}

src_install() {
	export INSTALLDIR=${D}/`ocamlc -where`/${PN}
	if use ocamlopt ; then
		./build install || die "install failed"
	else
		./build install-byte || die "install failed"
	fi

	dodoc CHANGES README
	use doc && dohtml doc/*
}
