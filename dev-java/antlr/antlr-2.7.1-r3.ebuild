# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.1-r3.ebuild,v 1.7 2003/08/15 06:00:29 strider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A parser generator for Java, C++ and Sather, written in Java"
SRC_URI="http://www.antlr.org/D00100100/antlr-2.7.1.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2
	jikes? ( >=dev-java/jikes-1.13 )
	>=sys-devel/gcc-2.95.3"
LICENSE="ANTLR"
SLOT="2"
KEYWORDS="x86"
IUSE="jikes"

src_compile() {
	if [ -n "`use jikes`" ] ; then
		export JAVAC=jikes
	fi
	PATH=${PATH}:${JAVA_HOME}/bin make all-jars || die
	cd lib/cpp
	econf || die
	emake || die
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

