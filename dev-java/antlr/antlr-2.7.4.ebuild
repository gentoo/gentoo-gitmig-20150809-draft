# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-2.7.4.ebuild,v 1.7 2005/02/05 15:59:53 luckyduck Exp $

inherit java-pkg gnuconfig

DESCRIPTION="A parser generator for Java and C++, written in Java"
SRC_URI="http://www.antlr.org/download/${P}.tar.gz"
HOMEPAGE="http://www.antlr.org"
DEPEND=">=virtual/jdk-1.2"
SLOT="0"
LICENSE="ANTLR"
KEYWORDS="~x86 ~amd64 ppc64"
IUSE="doc examples"

src_compile() {
	gnuconfig_update
	econf || die
	make all || die
}

src_install () {
	java-pkg_dojar *.jar

	insinto /usr/share/antlr
	doins extras/antlr-mode.el

	dobin scripts/antlr-config

	use doc && java-pkg_dohtml -r doc/*
	dodoc RIGHTS

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	cd lib/cpp
	make DESTDIR=$D install
}
