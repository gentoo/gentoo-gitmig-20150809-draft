# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ounit/ounit-1.0.0.ebuild,v 1.5 2004/09/30 18:28:50 mattam Exp $

inherit findlib

DESCRIPTION="Unit testing framework for OCaml"
HOMEPAGE="http://home.wanadoo.nl/maas/ocaml/"
SRC_URI="http://home.wanadoo.nl/maas/ocaml/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ppc amd64"
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
