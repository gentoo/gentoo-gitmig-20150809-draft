# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/detex/detex-2.7.ebuild,v 1.5 2004/01/25 12:56:23 dholm Exp $

DESCRIPTION="A filter program that removes the LaTeX (or TeX) control sequences"
HOMEPAGE="http://www.cs.purdue.edu/homes/trinkle/detex/"
SRC_URI="http://www.cs.purdue.edu/homes/trinkle/detex/${P}.tar"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""
DEPEND="virtual/glibc sys-devel/flex"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i -e "s:CFLAGS	= -O \${DEFS}:CFLAGS	= ${CFLAGS} \${DEFS}:" \
		-e 's:LEX	= lex:#LEX	= lex:' \
		-e 's:#LEX	= flex:LEX	= flex:' \
		-e 's:	${CC} ${CFLAGS} -o $@ ${D_OBJ} -ll:	${CC} ${CFLAGS} -o $@ ${D_OBJ} -lfl:' \
		Makefile || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin detex
	dodoc README
	doman detex.1l
}
