# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.1-r1.ebuild,v 1.1 2001/12/15 01:07:51 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A parser generator for Java"

SRC_URI="http://www.antlr.org/D00100100/antlr-2.7.1.tar.gz"

HOMEPAGE="http://www.antlr.org"

DEPEND=">=virtual/jdk-1.2
        >=dev-java/jikes-1.13"

src_compile() {
	PATH=${PATH}:${JAVA_HOME}/bin JAVAC=jikes make all-jars || die
}

src_install () {
	insinto /usr/share/antlr
	doins antlr.debug.jar antlr.jar antlrall.jar
	doins extras/antlr-mode.el
	dohtml -r doc/*
	cp -R examples ${D}/usr/share/doc/${P}/
	dodoc RIGHTS
}

