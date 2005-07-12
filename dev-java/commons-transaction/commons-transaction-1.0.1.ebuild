# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-transaction/commons-transaction-1.0.1.ebuild,v 1.2 2005/07/12 13:12:03 axxo Exp $

inherit java-pkg

DESCRIPTION="Commons Transaction aims at providing lightweight, standardized, well tested and efficient implementations of utility classes commonly used in transactional Java programming."
HOMEPAGE="http://jakarta.apache.org/commons/transaction/"
SRC_URI="mirror://apache/jakarta/commons/transaction/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jikes source"

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-codec
	dev-java/log4j"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from commons-codec
	java-pkg_jar-from log4j
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} jar || die "Compilation failed"
}

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc NOTICE.txt REAME.txt RELEASE-NOTES.txt
	java-pkg_dohtml -r build/doc/* xdocs
	use source && java-pkg_dosrc src/java/*
}
