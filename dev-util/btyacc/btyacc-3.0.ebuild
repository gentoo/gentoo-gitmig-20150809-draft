# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/btyacc/btyacc-3.0.ebuild,v 1.3 2004/03/06 11:34:18 dholm Exp $

MY_P=${P/./-}
IUSE=""
DESCRIPTION="Backtracking YACC - modified from Berkley YACC"
HOMEPAGE="http://www.siber.com/btyacc"
SRC_URI="http://www.siber.com/btyacc/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND="virtual/glibc"
S=${WORKDIR}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS= || die
}

src_install() {
	dobin btyacc
	dodoc README README.BYACC
	newman manpage btyacc.1
}
