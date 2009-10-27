# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fieldslib/fieldslib-0.1.0.ebuild,v 1.1 2009/10/27 12:08:13 aballier Exp $

EAPI="2"
inherit findlib

DESCRIPTION="Folding over record fields"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tgz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt]
	dev-ml/type-conv"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/lib

src_compile() {
	emake -j1 || die
}

src_test() {
	cd "${WORKDIR}/${P}/sample"
	emake || die
	./test.exe || die
}

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc ../README
}
