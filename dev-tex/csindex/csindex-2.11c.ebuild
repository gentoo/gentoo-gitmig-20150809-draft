# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/csindex/csindex-2.11c.ebuild,v 1.1 2004/02/26 20:09:11 usata Exp $

MY_P="${PN}-19980713"

DESCRIPTION="Utility for creating Czech/Slovak-sorted LaTeX index-files"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"
SRC_URI="ftp://math.feld.cvut.cz/pub/cstex/base/${MY_P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="MakeIndex"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${MY_P}"

src_compile() {

	emake CC="${CC}" CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	dobin csindex
	dodoc README
}
