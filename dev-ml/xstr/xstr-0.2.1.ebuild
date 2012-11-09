# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xstr/xstr-0.2.1.ebuild,v 1.3 2012/11/09 18:31:36 ago Exp $

inherit findlib

DESCRIPTION="Thread-safe implementation of string searching/matching/splitting."
HOMEPAGE="http://www.ocaml-programming.de/packages/"
LICENSE="as-is"
SRC_URI="http://www.ocaml-programming.de/packages/${P}.tar.gz"

SLOT="0"
IUSE=""
DEPEND=""
RDEPEND="$DEPEND"
KEYWORDS="~amd64 ppc x86"
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
