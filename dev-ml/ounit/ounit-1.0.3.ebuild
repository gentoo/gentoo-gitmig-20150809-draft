# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-1.0.3.ebuild,v 1.4 2009/09/28 16:26:13 betelgeuse Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
RDEPEND="${DEPEND}"
IUSE="+ocamlopt"

src_compile() {
	emake all || die "emake failed"
	if use ocamlopt; then
		emake allopt || die "failed to build native code"
	fi
}

src_install() {
	findlib_src_install

	# install documentation
	dodoc README changelog || die
}
