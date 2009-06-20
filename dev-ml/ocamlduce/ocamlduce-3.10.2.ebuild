# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlduce/ocamlduce-3.10.2.ebuild,v 1.2 2009/06/20 15:17:50 aballier Exp $

EAPI="2"

inherit eutils findlib

MY_P="${P/_p/pl}"
DESCRIPTION="OCamlDuce is a merger between OCaml and CDuce"
HOMEPAGE="http://www.cduce.org/ocaml.html"
SRC_URI="http://gallium.inria.fr/~frisch/ocamlcduce/download/${MY_P}.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="+ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	>=dev-ml/findlib-1.1.2"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	if use ocamlopt; then
		emake -j1 all opt || die "emake failed"
	else
		emake CAMLC="ocamlc" CAMLDEP="ocamldep" -j1 all || die "emake failed"
	fi
}

src_install() {
	dodir /usr/bin
	use ocamlopt && findlib_src_install BINDIR="${D}/usr/bin"
	use ocamlopt || findlib_src_install BINDIR="${D}/usr/bin" CAMLC="ocamlc" CAMLDEP="ocamldep" OPT_VARIANTS=""
}
