# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javacup/javacup-0.10k.ebuild,v 1.2 2004/10/17 09:49:42 dholm Exp $

inherit java-pkg

DESCRIPTION="CUP Parser Generator for Java"

HOMEPAGE="http://www.cs.princeton.edu/~appel/modern/java/CUP/"
SRC_URI="http://www.cs.princeton.edu/~appel/modern/java/CUP/java_cup_v10k.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="virtual/jdk"
RDEPEND="virtual/jre"

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
}
