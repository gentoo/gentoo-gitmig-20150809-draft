# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt/ispell-pt-20010720.ebuild,v 1.4 2004/02/22 18:26:35 agriffis Exp $

S=${WORKDIR}"/portugues"
DESCRIPTION="A Portuguese dictionary for ispell"
SRC_URI="http://www.di.uminho.pt/~jj/pln/UMportugues.tgz"
HOMEPAGE="http://natura.di.uminho.pt/~jj/pln/pln.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86 sparc alpha mips hppa"

DEPEND="app-text/ispell"


src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins portugues.aff portugues.hash

	dodoc README
}
