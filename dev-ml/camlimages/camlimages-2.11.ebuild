# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlimages/camlimages-2.11.ebuild,v 1.1 2003/06/20 06:33:44 george Exp $

IUSE=""

DESCRIPTION="Library used by active-dvi"
HOMEPAGE="http://pauillac.inria.fr/advi/"
SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/bazar-ocaml/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ocaml-3.06"


src_compile() {
	econf || die
	emake || die
	emake opt || die
}

src_install() {
	ldconf="${D}/usr/lib/ocaml/ld.conf"
	install -D /usr/lib/ocaml/ld.conf $ldconf
	make CAMLDIR=${D}/usr/lib/ocaml/ \
		LIBDIR=${D}/usr/lib/ocaml/camlimages \
		DESTDIR=${D} install || die
	install -D /usr/lib/ocaml/ld.conf $ldconf
	echo /usr/lib/ocaml/camlimages >> $ldconf
}
