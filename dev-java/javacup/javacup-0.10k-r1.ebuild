# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacup/javacup-0.10k-r1.ebuild,v 1.3 2006/10/05 17:22:17 gustavoz Exp $

inherit java-pkg-2

DESCRIPTION="CUP Parser Generator for Java"

HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/CUP/"
SRC_URI="http://www.cs.princeton.edu/~appel/modern/java/CUP/java_cup_v10k.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
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
	ejavac java_cup/*.java java_cup/runtime/*.java
	find java_cup -name "*.class" | xargs jar -cvf ${PN}.jar
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc CHANGELOG README
	dohtml manual.html
	use source && java-pkg_dosrc java_cup
}
