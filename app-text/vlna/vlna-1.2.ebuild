# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vlna/vlna-1.2.ebuild,v 1.1 2004/02/26 19:38:39 usata Exp $

DESCRIPTION="Add nonbreakable spaces after some prepositions in Czech texts"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"
SRC_URI="ftp://math.feld.cvut.cz/pub/olsak/vlna/${P}.tar.gz"

KEYWORDS="~x86"
SLOT="0"
LICENSE="Artistic"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${PN}"

src_compile() {

	emake CC="${CC}" CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {

	make DESTDIR=${D} \
		BINDIR=${D}/usr/bin \
		MANDIR=${D}/usr/share/man/man1 \
		install || die "make install failed"

	dodoc README vlna.txt
	insinto /usr/share/doc/${PF}
	doins vlna.dvi
}
