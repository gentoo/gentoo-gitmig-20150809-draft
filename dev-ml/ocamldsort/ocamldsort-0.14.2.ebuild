# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamldsort/ocamldsort-0.14.2.ebuild,v 1.1 2004/10/05 07:54:53 mattam Exp $

DESCRIPTION="A dependency sorter for OCaml source files"
HOMEPAGE="http://dimitri.mutu.net/ocaml.html"

SRC_URI="ftp://quatramaran.ens.fr/pub/ara/ocamldsort/${P}.tar.gz"

LICENSE="LGPL-2"

SLOT="0"

KEYWORDS="x86 ppc"

IUSE=""

DEPEND=">=dev-lang/ocaml-3.06"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make BINDIR=${D}/usr/bin MANDIR=${D}/usr/share/man install
	dodoc README
}

