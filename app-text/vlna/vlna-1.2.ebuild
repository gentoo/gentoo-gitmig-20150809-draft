# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vlna/vlna-1.2.ebuild,v 1.7 2005/01/06 19:35:52 sekretarz Exp $

inherit gcc

DESCRIPTION="Add nonbreakable spaces after some prepositions in Czech texts"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"
SRC_URI="ftp://math.feld.cvut.cz/pub/olsak/vlna/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(gcc-getCC)" CFLAGS="${CFLAGS}" || die "make failed"
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
