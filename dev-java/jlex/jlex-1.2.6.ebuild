# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jlex/jlex-1.2.6.ebuild,v 1.1 2003/05/15 01:59:44 absinthe Exp $

inherit java-pkg

S=${WORKDIR}/${P}
DESCRIPTION="JLex: a lexical analyzer generator for Java"
SRC_URI="mirror://gentoo/${PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/JLex/"
KEYWORDS="x86 ppc sparc alpha mips hppa arm"
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
	zip jlex.jar *.class
	java-pkg_doclass jlex.jar
}

