# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/equeue/equeue-2.0.1.ebuild,v 1.2 2004/09/03 00:38:23 dholm Exp $

inherit eutils findlib

DESCRIPTION="OCaml generic event queue module"
HOMEPAGE="http://www.ocaml-programming.de/programming/equeue.html"
LICENSE="as-is"
DEPEND=">=dev-lang/ocaml-3.07"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-bufsize.patch
}

src_compile() {
	# Haven't gotten tcl support working yet...
	./configure -with-equeue-core -with-shell -without-equeue-tcl || die
	make all opt || die
}

src_install () {
	findlib_src_install

	dodoc README doc/SHELL LICENSE

	if use doc; then
		dohtml doc/users-guide/html/*
		cp -R doc/refman-shell ${D}/usr/share/doc/${PF}/
		cp -R doc/refman-equeue ${D}/usr/share/doc/${PF}/
	fi
}
