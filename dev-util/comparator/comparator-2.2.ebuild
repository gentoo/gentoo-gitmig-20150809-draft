# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-2.2.ebuild,v 1.2 2003/12/18 20:18:39 kumba Exp $


DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	 http://www.catb.org/~esr/comparator/${P}.tar.gz"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="x86 sparc mips"
IUSE=""
DEPEND=""


src_compile() {

	# Fix the Makefile to accept our CFLAGS
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s/CFLAGS  = -O3/CFLAGS  = ${CFLAGS}/" ${S}/Makefile.orig > ${S}/Makefile
	emake || die
}

src_install() {
	dobin comparator
	dobin filterator
	doman comparator.1
}
