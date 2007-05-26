# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlgraph/ocamlgraph-0.98.ebuild,v 1.1 2007/05/26 19:34:05 aballier Exp $

inherit findlib

DESCRIPTION="O'Caml Graph library"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlgraph/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlgraph/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=">=dev-lang/ocaml-3.08
	doc? ( dev-tex/hevea dev-ml/ocamlweb )"
IUSE="doc"

src_compile() {
	econf || die
	emake || die

	if use doc;
	then
		emake doc
	fi
}

src_install() {
	findlib_src_preinst
	emake install-findlib || die

	dodoc README CREDITS FAQ CHANGES
	if use doc;
	then
		dohtml doc/*
	fi
}
