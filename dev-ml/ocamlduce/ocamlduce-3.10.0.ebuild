# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlduce/ocamlduce-3.10.0.ebuild,v 1.2 2008/01/03 23:43:12 aballier Exp $

inherit eutils findlib

EAPI="1"

MY_P="${P/_p/pl}"
DESCRIPTION="OCamlDuce is a merger between OCaml and CDuce"
HOMEPAGE="http://www.cduce.org/ocaml.html"
SRC_URI="http://gallium.inria.fr/~frisch/ocamlcduce/download/${MY_P}.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.0
	>=dev-ml/findlib-1.1.2"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use ocamlopt && ! built_with_use --missing true dev-lang/ocaml ocamlopt; then
		eerror "In order to build ${PN} with native code support from ocaml"
		eerror "You first need to have a native code ocaml compiler."
		eerror "You need to install dev-lang/ocaml with ocamlopt useflag on."
		die "Please install ocaml with ocamlopt useflag"
	fi
}

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
