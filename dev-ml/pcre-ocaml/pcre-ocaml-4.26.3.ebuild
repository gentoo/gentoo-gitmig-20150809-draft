# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-4.26.3.ebuild,v 1.2 2002/07/22 06:57:45 george Exp $

DESCRIPTION="Perl Compatibility Regular Expressions for OCaml"
HOMEPAGE="http://www.ai.univie.ac.at/~markus/home/ocaml_sources.html"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.04-r1
	>=dev-libs/libpcre-3.9-r1"
RDEPEND="${DEPEND}"
	
SRC_URI="http://www.ai.univie.ac.at/~markus/ocaml_sources/pcre-ocaml-4.26.3.tar.bz2"
S=${WORKDIR}/${P}

SLOT="3"
KEYWORDS="x86"

src_compile() {
	make all opt || die
}

src_install () {
	make OCAMLLIBPATH=${D}/usr/lib/ocaml install || die
	mv ${D}/usr/lib/ocaml/contrib/* ${D}/usr/lib/ocaml || die
	rmdir ${D}/usr/lib/ocaml/contrib || die

	dodoc LICENSE README VERSION META
}
