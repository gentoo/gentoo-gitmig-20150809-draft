# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.2_alpha2.ebuild,v 1.2 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${PN}-2.7.2a2
DESCRIPTION="A parser generator for Java, C++ and Sather, written in Java"
SRC_URI="http://www.antlr.org/nirvana/antlr-2.7.2a2.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2
	>=dev-java/jikes-1.13"
SLOT="2"
LICENSE="ANTLR"

src_compile() {

	if [ ! -f antlrall.jar ] ; then 
		./mkalljar
	fi

	export JAVAC=jikes

	echo $CLASSPATH
	econf || die	
	make all || die

#	cd lib/cpp
#	econf || die
#	emake || die
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

