# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-regexp/gnu-regexp-1.1.4.ebuild,v 1.11 2005/05/01 09:58:42 luckyduck Exp $

inherit java-pkg

MY_P=gnu.regexp-${PV}
DESCRIPTION="GNU regular expression package for Java"
HOMEPAGE="http://www.cacas.org/java/gnu/regexp/"
SRC_URI="ftp://ftp.tralfamadore.com/pub/java/gnu.regexp-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.2"
RDEPEND=">=virtual/jre-1.2"

S=${WORKDIR}/${MY_P}

src_compile() {
	patch src/Makefile ${FILESDIR}/${PV}/Makefile.diff
	cd src
	make || die "failed too build"
}

src_install () {
	java-pkg_dojar lib/gnu-regexp-${PV}.jar
	dodoc README TODO
	java-pkg_dohtml -r docs/*
}
