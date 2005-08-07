# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacup/javacup-0.10k.ebuild,v 1.10 2005/08/07 12:51:39 hansmi Exp $

inherit java-pkg

DESCRIPTION="CUP Parser Generator for Java"

HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/CUP/"
SRC_URI="http://www.cs.princeton.edu/~appel/modern/java/CUP/java_cup_v10k.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="source"
DEPEND=">=virtual/jdk-1.3
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -name "*.class" -exec rm -f {} \;
}

src_compile() {
	javac java_cup/*.java java_cup/runtime/*.java || die "failed to compile"
	find java_cup -name "*.class" | xargs jar -cvf ${PN}.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc CHANGELOG README LICENSE
	dohtml manual.html
	use source && java-pkg_dosrc java_cup
}
