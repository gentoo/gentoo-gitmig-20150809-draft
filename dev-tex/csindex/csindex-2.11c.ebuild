# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/csindex/csindex-2.11c.ebuild,v 1.6 2005/05/16 04:28:14 usata Exp $

inherit toolchain-funcs

MY_P="${PN}-19980713"

DESCRIPTION="Utility for creating Czech/Slovak-sorted LaTeX index-files"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"
SRC_URI="ftp://math.feld.cvut.cz/pub/cstex/base/${MY_P}.tar.gz"

LICENSE="MakeIndex"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dobin csindex || die
	dodoc README
}
