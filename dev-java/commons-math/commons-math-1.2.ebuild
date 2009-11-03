# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-math/commons-math-1.2.ebuild,v 1.2 2009/11/03 09:00:31 betelgeuse Exp $

EAPI="2"

WANT_ANT_TASKS="ant-junit"
EANT_GENTOO_CLASSPATH="commons-discovery,commons-logging,junit"
JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_PKG_IUSE="test source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Lightweight, self-contained mathematics and statistics components"
HOMEPAGE="http://commons.apache.org/math/"
SRC_URI="mirror://apache/commons/math/source/${P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE=""

COMMON_DEP="
	>=dev-java/commons-discovery-0.2:0
	>=dev-java/commons-logging-1.0.3:0"

DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	test? ( dev-java/ant-junit )"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${P}-src"

src_prepare() {
	sed -i -e 's/depends="get-deps"//' \
		-e 's/depends="compile,test"/depends="compile"/' "${S}/build.xml" || die
}

src_compile() {
	eant -Duser.home="${WORKDIR}/user_home"
}

src_test() {
	eant -Duser.home="${WORKDIR}/user_home" test
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar
	use source && java-pkg_dosrc src/java/org
}
