# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-expat/ocaml-expat-0.9.1.ebuild,v 1.1 2007/02/06 21:26:43 nattfodd Exp $

inherit findlib eutils

IUSE="doc"

DESCRIPTION="OCaml bindings for expat"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"

DEPEND="dev-libs/expat"

RDEPEND="$DEPEND"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_compile() {
	emake depend all allopt || die "make failed"
}

src_install() {
	findlib_src_preinst
	emake install || die

	if use doc ; then
		dohtml -r doc/html/*
	fi
	dodoc README
}
