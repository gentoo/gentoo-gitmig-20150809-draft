# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-5.08.1.ebuild,v 1.3 2005/03/27 15:12:23 mattam Exp $

inherit findlib

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.oefai.at/~markus/home/ocaml_sources.html"
SRC_URI="http://www.oefai.at/~markus/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.07
	>=dev-libs/libpcre-4.5"
SLOT="0"
IUSE=""
KEYWORDS="x86 ~ppc amd64"

src_compile() {
	make all || die
}

src_install () {
	findlib_src_install

	# install documentation
	dodoc LICENSE README VERSION
}
