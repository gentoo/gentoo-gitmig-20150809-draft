# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-transaction/commons-transaction-1.0.1-r1.ebuild,v 1.3 2008/01/05 17:57:50 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A library of utility classes commonly used in transactional Java programming."
HOMEPAGE="http://jakarta.apache.org/commons/transaction/"
SRC_URI="mirror://apache/jakarta/commons/transaction/source/${P}-src.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/commons-codec
	dev-java/jta
	dev-java/log4j"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	rm -v *.jar || die
	cd "${S}/lib"
	rm -f *.jar || die
	java-pkg_jar-from commons-codec
	java-pkg_jar-from log4j
	java-pkg_jar-from jta
}

EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar dist/lib/${P}.jar ${PN}.jar

	dodoc NOTICE.txt README.txt RELEASE-NOTES.txt || die
	dohtml -r xdocs/* || die
	use doc && java-pkg_dojavadoc build/doc/apidocs
	use source && java-pkg_dosrc src/java/*
}
