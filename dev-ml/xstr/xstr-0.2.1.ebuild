# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xstr/xstr-0.2.1.ebuild,v 1.2 2005/03/19 01:09:58 swegener Exp $

inherit findlib

DESCRIPTION="Thread-safe implementation of string searching/matching/splitting."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
LICENSE="as-is"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="$DEPEND"
KEYWORDS="x86 ppc"
S="${WORKDIR}/${PN}"

src_compile()
{
	make all || die
	make opt || die
}

src_install()
{
	findlib_src_install
	dodoc LICENSE README RELEASE
}
