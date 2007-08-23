# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/pcre-ocaml/pcre-ocaml-5.12.1.ebuild,v 1.1 2007/08/23 08:50:31 aballier Exp $

inherit findlib

DESCRIPTION="Perl Compatibility Regular Expressions for O'Caml"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://www.ocaml.info/ocaml_sources/${P}.tar.bz2"
LICENSE="LGPL-2.1"

DEPEND=">=dev-lang/ocaml-3.07
	>=dev-libs/libpcre-4.5"
SLOT="0"
IUSE="examples"
KEYWORDS="~amd64 ~ppc ~x86"

src_install () {
	findlib_src_install

	# install documentation
	dodoc README VERSION Changes

	if use examples; then
		for dir in examples/*
		do
		  docinto $dir
		  dodoc $dir/*
		done
	fi
}
