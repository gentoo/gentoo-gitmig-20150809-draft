# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-1.0.1.ebuild,v 1.1 2005/02/06 15:53:36 mattam Exp $

inherit findlib

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://www.xs4all.nl/~mmzeeman/ocaml/"
SRC_URI="http://www.xs4all.nl/~mmzeeman/ocaml/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
DEPEND="dev-lang/ocaml"
IUSE=""

src_compile() {
	emake all allopt || die "emake failed"
}

src_install() {
	findlib_src_install

	# typo
	mv LICENCE LICENSE
	# install documentation
	dodoc README LICENSE changelog
}
