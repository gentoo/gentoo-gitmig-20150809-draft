# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.4.ebuild,v 1.5 2005/01/01 18:07:24 eradicator Exp $

inherit java-pkg gnuconfig

DESCRIPTION="A parser generator for Java and C++, written in Java"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2"
SLOT="0"
LICENSE="ANTLR"
KEYWORDS="~x86 ~amd64 ~ppc64"
IUSE=""

src_compile() {
	gnuconfig_update
	econf || die
	make all || die
}

src_install () {
	insinto /usr/share/antlr
	java-pkg_dojar *.jar
	doins extras/antlr-mode.el
	java-pkg_dohtml -r doc/*
	cp -R examples ${D}/usr/share/doc/${P}/
	dodoc RIGHTS
	cd lib/cpp
	make DESTDIR=$D install
}
