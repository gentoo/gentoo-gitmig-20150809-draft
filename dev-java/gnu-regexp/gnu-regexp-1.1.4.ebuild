# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-regexp/gnu-regexp-1.1.4.ebuild,v 1.5 2004/04/05 05:10:49 zx Exp $

DESCRIPTION="GNU regular expression package for Java"
HOMEPAGE="http://www.cacas.org/java/gnu/regexp/"
SRC_URI="ftp://ftp.tralfamadore.com/pub/java/gnu.regexp-${PV}.tar.gz"
MY_P=gnu.regexp-${PV}
S=${WORKDIR}/${MY_P}
LICENSE="LGPL-2.1"
SLOT="1"
DEPEND=">=virtual/jdk-1.2"
KEYWORDS="x86 ~ppc"

src_unpack() {
	unpack ${MY_P}.tar.gz
}

src_compile() {
	patch src/Makefile ${FILESDIR}/${PV}/Makefile.diff
	cd src
	make
}

src_install () {
	dojar lib/gnu-regexp-${PV}.jar
	dodoc COPYING.LIB README TODO
	dohtml docs/* -r
}
