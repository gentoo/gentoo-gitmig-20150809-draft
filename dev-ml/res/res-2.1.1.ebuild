# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/res/res-2.1.1.ebuild,v 1.4 2005/02/17 20:48:17 mattam Exp $

inherit findlib

DESCRIPTION="Resizable Array and Buffer modules for O'Caml"
HOMEPAGE="http://www.oefai.at/~markus/home/ocaml_sources.html"
SRC_URI="http://www.oefai.at/~markus/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.07"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE="doc"

src_compile() {
	emake -j1 all || die

	if use doc; then
		cd lib && make htdoc
	fi
}

src_install () {
	findlib_src_install

	# install documentation
	dodoc LICENSE README TODO VERSION Changes

	if use doc; then
		dohtml lib/doc/html/*
	fi
}
