# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camlimages/camlimages-2.11-r1.ebuild,v 1.3 2004/06/25 00:01:21 agriffis Exp $

IUSE=""

DESCRIPTION="Library used by active-dvi"
HOMEPAGE="http://pauillac.inria.fr/advi/"
SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/bazar-ocaml/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-lang/ocaml-3.06"


src_compile() {
	econf || die
	emake || die
	emake opt || die
}

src_install() {
	make CAMLDIR=${D}/usr/lib/ocaml/ \
		LIBDIR=${D}/usr/lib/ocaml/camlimages \
		DESTDIR=${D} \
		OCAML_LDCONF=dummy \
		install || die
}

pkg_postinst() {
	ldconf="/usr/lib/ocaml/ld.conf"
	echo /usr/lib/ocaml/camlimages >> $ldconf
}
