# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gnu-regexp/gnu-regexp-1.1.4.ebuild,v 1.13 2005/07/12 15:47:11 axxo Exp $

inherit java-pkg eutils

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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}/Makefile.diff
}

src_compile() {
	cd src
	make || die "failed too build"
}

src_install() {
	java-pkg_dojar lib/gnu-regexp-${PV}.jar
	dodoc README TODO
	java-pkg_dohtml -r docs/*
}
