# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.2.ebuild,v 1.9 2004/01/20 05:25:53 strider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A parser generator for Java and C++, written in Java"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2
	jikes? ( >=dev-java/jikes-1.13 )"
SLOT="2"
LICENSE="ANTLR"
KEYWORDS="x86 ~ppc sparc amd64"
IUSE="jikes"

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/${P}-gcc3-gentoo.patch || die
}

src_compile() {
	if [ -n "`use jikes`" ] ; then
		export JAVAC=jikes
	fi
	echo $CLASSPATH
	econf || die
	make antlr.jar antlr.debug.jar antlrall.jar all || die
}

src_install () {
	insinto /usr/share/antlr
	dojar antlr.debug.jar antlr.jar antlrall.jar
	doins extras/antlr-mode.el
	dohtml -r doc/*
	cp -R examples ${D}/usr/share/doc/${P}/
	dodoc RIGHTS
	cd lib/cpp
	make DESTDIR=$D install
}

