# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/react/react-0.9.3.ebuild,v 1.1 2012/03/18 16:22:49 aballier Exp $

EAPI="4"

inherit multilib findlib

DESCRIPTION="OCaml module for functional reactive programming"
HOMEPAGE="http://erratique.ch/software/react"
SRC_URI="http://erratique.ch/software/react/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="+ocamlopt debug test"

DEPEND=">=dev-lang/ocaml-3.11[ocamlopt?]"
RDEPEND="${DEPEND}"

oasis_use_enable() {
	echo "--override $2 `use $1 && echo \"true\" || echo \"false\"`"
}

src_configure() {
	ocaml setup.ml -configure \
		--prefix usr \
		--libdir /usr/$(get_libdir) \
		--destdir "${D}" \
		$(oasis_use_enable debug debug) \
		$(oasis_use_enable ocamlopt is_native) \
		$(use_enable test tests) \
		|| die
}

src_compile() {
	ocaml setup.ml -build || die
}

src_test() {
	ocaml setup.ml -test || die
}

src_install() {
	findlib_src_preinst
	ocaml setup.ml -install || die
	dodoc CHANGES README
}
