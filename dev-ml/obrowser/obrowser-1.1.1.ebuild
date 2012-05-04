# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/obrowser/obrowser-1.1.1.ebuild,v 1.3 2012/05/04 12:29:20 aballier Exp $

EAPI=3

inherit findlib

DESCRIPTION="OCaml virtual machine written in Javascript, to run OCaml program in browsers"
HOMEPAGE="http://ocsigen.org/obrowser/"
SRC_URI="http://ocsigen.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1 GPL-3 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ocaml-3.12.0
	dev-ml/lwt"
DEPEND="${RDEPEND}
	app-arch/sharutils"

src_compile() {
	touch .check_version
	emake -j1 EXAMPLES_TARGETS="" || die
}

src_install() {
	findlib_src_preinst
	OCAMLPATH=${OCAMLFIND_DESTDIR} emake DESTDIR="${D}" install || die
	dodoc README.TXT || die
}
