# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlduce/ocamlduce-3.09.3_p1.ebuild,v 1.1 2007/03/28 16:07:03 aballier Exp $

inherit eutils findlib

MY_P="${P/_p/pl}"
DESCRIPTION="OCamlDuce is a merger between OCaml and CDuce"
HOMEPAGE="http://www.cduce.org/ocaml.html"
SRC_URI="http://gallium.inria.fr/~frisch/ocamlcduce/download/${MY_P}.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=dev-lang/ocaml-3.09.3
	>=dev-ml/findlib-1.1.2"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake -j1 all opt || die "emake failed"
}

src_install() {
	mkdir -p "${D}/usr/bin"
	findlib_src_install BINDIR="${D}/usr/bin"
}
