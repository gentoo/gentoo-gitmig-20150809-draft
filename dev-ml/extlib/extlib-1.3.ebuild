# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/extlib/extlib-1.3.ebuild,v 1.1 2005/02/06 15:47:19 mattam Exp $

inherit findlib

DESCRIPTION="Standard library extensions for O'Caml"
HOMEPAGE="http://ocaml-lib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ocaml-lib/${P}.tgz"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ocaml-3.07"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

src_compile() {
	sed -i -e "s/IOO//" Makefile
	make all opt

	if use doc; then
		make doc
	fi
}

src_install () {
	findlib_src_install

	# install documentation
	dodoc README.txt

	if use doc; then
		dohtml doc/*
	fi
}
