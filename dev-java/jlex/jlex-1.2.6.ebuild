# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jlex/jlex-1.2.6.ebuild,v 1.5 2004/04/26 03:16:00 zx Exp $

inherit java-pkg

DESCRIPTION="JLex: a lexical analyzer generator for Java"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/JLex/"
KEYWORDS="x86 ppc sparc"
LICENSE="jlex"
SLOT="0"
DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.2"
IUSE="doc jikes"

src_compile() {
	use jikes && jikes -q Main.java || javac -nowarn Main.java
}

src_install() {
	dodoc LICENSE README Bugs
	use doc && dohtml manual.html
	use doc && dodoc sample.lex
	mkdir JLex && mv *.class JLex/
	zip -rq jlex.jar JLex/
	java-pkg_doclass jlex.jar
}
