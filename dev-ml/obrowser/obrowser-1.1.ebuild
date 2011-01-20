# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/obrowser/obrowser-1.1.ebuild,v 1.2 2011/01/20 23:39:13 aballier Exp $

EAPI=3

inherit findlib eutils

DESCRIPTION="OCaml virtual machine written in Javascript, to run OCaml program in browsers"
HOMEPAGE="http://ocsigen.org/obrowser/"
SRC_URI="http://ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1 GPL-3 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/ocaml-3.11.0"
DEPEND="${RDEPEND}
	app-arch/sharutils"

S=${WORKDIR}/${PN}

src_prepare() {
	has_version '>=dev-lang/ocaml-3.12' && epatch "${FILESDIR}/${P}-ocaml312.patch"
}

src_compile() {
	emake -j1 EXAMPLES_TARGETS="" || die
}

src_install() {
	findlib_src_preinst
	OCAMLPATH=${OCAMLFIND_DESTDIR} emake DESTDIR="${D}" install || die
	dodoc README.TXT || die
}
