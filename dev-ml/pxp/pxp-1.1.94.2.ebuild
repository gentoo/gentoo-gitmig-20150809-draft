# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pxp/pxp-1.1.94.2.ebuild,v 1.1 2005/03/09 00:08:31 mattam Exp $

inherit findlib

DESCRIPTION="validating XML parser library for O'Caml"
HOMEPAGE="http://www.ocaml-programming.de/packages/documentation/pxp/index_dev.html"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86 ~ppc"

SLOT="0"
DEPEND=">=dev-ml/pcre-ocaml-4.31
>=dev-ml/ocamlnet-0.98"

IUSE="doc"

src_compile() {
	#the included configure does not support  many standard switches and is quite picky
	./configure || die
	make all opt || die
}

src_install() {
	findlib_src_install

	cd doc
	dodoc ABOUT-FINDLIB DEV EXTENSIONS INSTALL README RELEASE-NOTES SPEC design.txt

	if use doc; then
		dodoc manual/ps/pxp.ps
		dohtml manual/html/*
		insinto /usr/share/doc/${PF}/html/pic
		doins manual/html/pic/*
	fi
}
