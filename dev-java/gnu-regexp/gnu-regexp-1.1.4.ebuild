# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-regexp/gnu-regexp-1.1.4.ebuild,v 1.9 2004/10/20 07:18:18 absinthe Exp $

inherit java-pkg

DESCRIPTION="GNU regular expression package for Java"
HOMEPAGE="http://www.cacas.org/java/gnu/regexp/"
SRC_URI="ftp://ftp.tralfamadore.com/pub/java/gnu.regexp-${PV}.tar.gz"
MY_P=gnu.regexp-${PV}
S=${WORKDIR}/${MY_P}
LICENSE="LGPL-2.1"
SLOT="1"
DEPEND=">=virtual/jdk-1.2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

src_compile() {
	patch src/Makefile ${FILESDIR}/${PV}/Makefile.diff
	cd src
	make || die "failed too build"
}

src_install () {
	java-pkg_dojar lib/gnu-regexp-${PV}.jar
	dodoc COPYING.LIB README TODO
	java-pkg_dohtml -r docs/*
}
