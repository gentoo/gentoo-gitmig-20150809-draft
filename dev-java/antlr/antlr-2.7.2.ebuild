# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.2.ebuild,v 1.2 2003/04/06 00:08:43 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A parser generator for Java and C++, written in Java"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/jikes-1.13"
SLOT="2"
LICENSE="ANTLR"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S} && patch -p1 <${FILESDIR}/${P}-gcc3-gentoo.patch || die
}

src_compile() {

	if [ ! -f antlrall.jar ] ; then 
		./mkalljar
	fi

	export JAVAC=jikes

	echo $CLASSPATH
	econf || die	
	make all || die
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

