# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.3.ebuild,v 1.1 2004/03/23 04:09:33 zx Exp $

inherit java-pkg

DESCRIPTION="A parser generator for Java and C++, written in Java"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2"
SLOT="0"
LICENSE="ANTLR"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="jikes"

src_compile() {
	econf || die
	make all || die
}

src_install () {
	insinto /usr/share/antlr
	java-pkg_dojar *.jar
	doins extras/antlr-mode.el
	dohtml -r doc/*
	cp -R examples ${D}/usr/share/doc/${P}/
	dodoc RIGHTS
	cd lib/cpp
	make DESTDIR=$D install
}

