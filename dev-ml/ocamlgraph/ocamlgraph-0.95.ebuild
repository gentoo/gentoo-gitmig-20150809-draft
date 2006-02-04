# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlgraph/ocamlgraph-0.95.ebuild,v 1.1 2006/02/04 17:09:05 mattam Exp $

inherit findlib

DESCRIPTION="O'Caml Graph library"
HOMEPAGE="http://www.lri.fr/~filliatr/ocamlgraph/"
SRC_URI="http://www.lri.fr/~filliatr/ftp/ocamlgraph/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
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
	make install-findlib || die

	dodoc README COPYING CREDITS FAQ CHANGES
	if use doc;
	then
		dohtml doc/*
	fi
}
