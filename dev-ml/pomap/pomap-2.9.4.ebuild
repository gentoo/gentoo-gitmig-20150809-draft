# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pomap/pomap-2.9.4.ebuild,v 1.4 2004/08/30 23:27:34 dholm Exp $

inherit findlib

DESCRIPTION="Partially Ordered Map ADT for O'Caml"
HOMEPAGE="http://www.ai.univie.ac.at/~markus/home/ocaml_sources.html"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ocaml-3.06"
SRC_URI="http://www.oefai.at/~markus/ocaml_sources/${P}.tar.bz2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

src_compile() {
	emake all || die
}

src_install () {
	findlib_src_install

	# install documentation
	dodoc LICENSE README VERSION Changes

	#install examples
	mv ${S}/examples/ ${D}/usr/share/doc/${PF}/
}
