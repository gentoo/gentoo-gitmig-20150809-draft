# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-4.33.0.ebuild,v 1.2 2003/09/08 03:01:53 msterret Exp $

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.ai.univie.ac.at/~markus/home/ocaml_sources.html"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.04-r1
	>=dev-libs/libpcre-3.9-r1
	>=dev-ml/findlib-0.8"

SRC_URI="http://www.oefai.at/~markus/ocaml_sources/${P}.tar.bz2"
S=${WORKDIR}/${P}

SLOT="3"
KEYWORDS="x86"
IUSE=""

src_compile() {
	emake all || die
}

src_install () {
	# which directory does the lib go into?
	destdir=`ocamlfind printconf destdir`

	# install
	mkdir -p ${D}${destdir} || die
	make	OCAMLFIND_DESTDIR=${D}${destdir} \
		OCAMLFIND_LDCONF=dummy install || die

	# install documentation
	dodoc LICENSE README VERSION
}
