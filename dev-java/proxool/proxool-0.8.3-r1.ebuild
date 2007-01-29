# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/proxool/proxool-0.8.3-r1.ebuild,v 1.3 2007/01/29 16:03:43 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Proxool is a Java connection pool."
HOMEPAGE="http://proxool.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source"

# We could add java5 use flag but the sources use enum
# Making this ebuild quite complex. The mx4j-core dep
# can be obsoloted by the java virtuals any way.
COMMON_DEP="
	dev-java/log4j
	=dev-java/servletapi-2.4*
	=dev-java/avalon-framework-4.2*
	=dev-java/avalon-logkit-2*
	=dev-java/mx4j-core-3*"

RDEPEND="
	>=virtual/jre-1.4
	${COMMON_DEP}
	"

DEPEND="
	>=virtual/jdk-1.4
	${COMMON_DEP}
	dev-java/ant-core
	dev-util/checkstyle
	source? ( app-arch/zip )"

EANT_BUILD_TARGET="build-jar"

src_unpack() {
	unpack "${A}"
	cd "${S}"/lib
	rm -v *.jar
	java-pkg_jar-from log4j
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from avalon-framework-4.2
	java-pkg_jar-from avalon-logkit-2.0
	java-pkg_jar-from mx4j-core-3.0
}

src_test() {
	einfo "Tests disabled because they would need hibernate"
	einfo "and as such creating a circular dependency"
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar

	dodoc README.txt
	# dohtml valid as there are other docs too
	use doc && java-pkg_dohtml -r doc/*
	use source && java-pkg_dosrc src/java/*
}
