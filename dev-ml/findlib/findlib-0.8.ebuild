# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/findlib/findlib-0.8.ebuild,v 1.6 2004/03/30 09:30:54 aliz Exp $

IUSE=""

DESCRIPTION="OCaml tool to find/use non-standard packages."
HOMEPAGE="http://www.ocaml-programming.de/programming/download-caml.html"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~amd64"

DEPEND="dev-lang/ocaml"

src_compile() {
	./configure -bindir /usr/bin -mandir /usr/share/man \
		-sitelib /usr/lib/ocaml/site-packages/ \
		-config /usr/lib/ocaml/site-packages/findlib/findlib.conf || die "configure failed"

	make all || die
	make opt || die # optimized code
}

src_install() {
	make PREFIX=${D} install || die

	cd ${S}/doc
	dodoc QUICKSTART README
	dohtml html/*
}
