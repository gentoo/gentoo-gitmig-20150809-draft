# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlimages/camlimages-2.11-r1.ebuild,v 1.4 2005/02/06 15:28:50 mattam Exp $

inherit findlib

IUSE=""

DESCRIPTION="Library used by active-dvi"
HOMEPAGE="http://pauillac.inria.fr/advi/"
SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/bazar-ocaml/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=dev-lang/ocaml-3.06"

src_compile() {
	econf || die
	emake || die
	emake opt || die
}

src_install() {
	findlib_src_preinst

	make CAMLDIR=${D}/usr/lib/ocaml/ \
		LIBDIR=${D}/usr/lib/ocaml/camlimages \
		DESTDIR=${D} \
		install || die
}
