# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pxp/pxp-1.1.6.ebuild,v 1.3 2004/08/30 23:28:41 dholm Exp $

inherit findlib

DESCRIPTION="validating XML parser library for O'Caml"
HOMEPAGE="http://www.ocaml-programming.de/packages/documentation/pxp/index_dev.html"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="doc"

DEPEND="dev-lang/ocaml
>=dev-ml/pcre-ocaml-4.31
>=dev-ml/ocamlnet-0.94"

src_compile() {
	#the included configure does not support many standard switches and is quite picky
	./configure || die
	make all opt || die
}

src_install() {
	findlib_src_install

	cd doc
	dodoc ABOUT-FINDLIB DEV EXTENSIONS README RELEASE-NOTES SPEC design.txt

	if use doc; then
		dodoc manual/ps/pxp.ps
		dohtml manual/html/*
		insinto /usr/share/doc/${PF}/html/pic
		doins manual/html/pic/*
	fi
}
