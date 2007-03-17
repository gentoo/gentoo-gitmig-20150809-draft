# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ecs/ecs-1.4.2-r1.ebuild,v 1.1 2007/03/17 20:44:22 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library to generate markup language text such as HTML and XML"
HOMEPAGE="http://jakarta.apache.org/ecs"
SRC_URI="mirror://apache/jakarta/ecs/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.4
	=dev-java/jakarta-regexp-1.3*
	>=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}

	cd "${S}"
	rm -f lib/*.jar
	rm -f build/*.jar
	rm -f ecs*.jar

	java-ant_bsfix_one build/build-ecs.xml

	cd "${S}/lib"
	java-pkg_jar-from xerces-2 xercesImpl.jar xerces.jar
	java-pkg_jar-from jakarta-regexp-1.3 jakarta-regexp.jar regexp.jar
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadocs"
	eant -f build/build-ecs.xml ${antflags}
}

src_install() {
	java-pkg_newjar bin/${P}.jar ${PN}.jar

	dodoc AUTHORS ChangeLog README
	use doc && java-pkg_dojavadoc docs/*
	use source && java-pkg_dosrc src/java/*
}
