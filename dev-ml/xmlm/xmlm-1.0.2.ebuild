# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xmlm/xmlm-1.0.2.ebuild,v 1.1 2011/02/21 15:01:40 aballier Exp $

EAPI=3

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="http://erratique.ch/software/xmlm"
SRC_URI="http://erratique.ch/software/${PN}/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
RDEPEND="${DEPEND}"

src_compile() {
	./build module-byte || die "bytecode failed"
	if use ocamlopt ; then
		./build module-native && ./build module-plugin || die "native code failed"
	fi
	if use doc ; then
		./build doc || die "doc building failed"
	fi
}

src_install() {
	export INSTALLDIR=${D}/`ocamlc -where`/${PN}
	if use ocamlopt ; then
		./build install || die "install failed"
		./build install-plugin || "install-plugin failed"
	else
		./build install-byte || die "install failed"
	fi
	dodoc CHANGES README || die
	use doc && dohtml doc/*
}
