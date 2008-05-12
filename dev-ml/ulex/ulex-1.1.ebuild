# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ulex/ulex-1.1.ebuild,v 1.1 2008/05/12 07:09:11 aballier Exp $

inherit eutils findlib

EAPI="1"

DESCRIPTION="A lexer generator for unicode"
HOMEPAGE="http://www.cduce.org"
SRC_URI="http://www.cduce.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.0"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

src_compile() {
	emake all || die "failed to build bytecode"
	if use ocamlopt; then
		emake all.opt || die "failed to build native code"
	fi
}

src_install() {
	findlib_src_install
	dodoc README CHANGES
}
