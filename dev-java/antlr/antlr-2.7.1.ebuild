# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.1.ebuild,v 1.1 2001/09/27 21:22:45 karltk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A parser generator for Java"

SRC_URI="http://www.antlr.org/D00100100/antlr-2.7.1.tar.gz"

HOMEPAGE="http://www.antlr.org"

DEPEND=">=dev-java/blackdown-sdk-1.3.1
        >=dev-java/jikes-1.13"

src_compile() {
    PATH=$PATH:/opt/blackdown-sdk-1.3.1/bin JAVAC=jikes make all-jars
}

src_install () {
    echo ${P}
    dodir usr/share/antlr
    insinto usr/share/antlr
    doins antlr.debug.jar antlr.jar antlrall.jar
    doins extras/antlr-mode.el
    dodir usr/share/doc/${P}/html
    cp doc/* ${D}/usr/share/doc/${P}/html
    cp -R examples ${D}/usr/share/doc/${P}/
    dodoc RIGHTS
}

