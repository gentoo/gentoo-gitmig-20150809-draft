# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/comparator/comparator-1.0.ebuild,v 1.1 2003/09/10 03:49:10 kumba Exp $


DESCRIPTION="ESR's utility for making fast comparisons among large source trees"
HOMEPAGE="http://www.catb.org/~esr/comparator/"
SRC_URI="http://www.catb.org/~esr/comparator/${P}.tar.gz"
LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""
DEPEND=""


src_compile() {
	mv ${S}/Makefile ${S}/Makefile.orig
	sed -e "s/CFLAGS=-g/CFLAGS=${CFLAGS}/" ${S}/Makefile.orig > ${S}/Makefile
	emake || die
}

src_install() {
	dobin comparator
	dobin filterator
	doman comparator.1
}
