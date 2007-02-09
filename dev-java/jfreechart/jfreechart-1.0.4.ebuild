# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-1.0.4.ebuild,v 1.1 2007/02/09 23:51:12 fordfrog Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"
COMMON_DEPEND="
	>=dev-java/itext-1.4.6
	>=dev-java/jcommon-1.0.0
	=dev-java/servletapi-2.3*"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}
	!test? ( dev-java/ant-core )
	test? ( dev-java/ant
		=dev-java/junit-3.8* )"
RDEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# We do not fork junit tests because we need to disable X11 support for all tests
	use test && epatch ${FILESDIR}/${P}-build.xml.patch

	rm -f lib/* *.jar
}

src_compile() {
	# Note that compile-experimental depends on compile so it is sufficient to run
	# just compile-experimental
	eant -f ant/build.xml compile-experimental $(use_doc) $(get_jars)
}

# Please note that currently tests fail.
# See http://sourceforge.net/tracker/index.php?func=detail&aid=1656438&group_id=15494&atid=115494
src_test() {
	# X11 tests are disabled using java.awt.headless=true
	ANT_TASKS="ant-junit" ANT_OPTS="-Djava.awt.headless=true" eant -f ant/build.xml test $(get_jars)
}

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	java-pkg_newjar ${P}-experimental.jar ${PN}-experimental.jar
	dodoc README.txt CHANGELOG.txt
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc source/org
}

get_jars() {
	local antflags="
		-Ditext.jar=$(java-pkg_getjars itext) \
		-Djcommon.jar=$(java-pkg_getjars jcommon-1.0) \
		-Dservlet.jar=$(java-pkg_getjars servletapi-2.3)"
	use test && antflags="${antflags} \
		-Djunit.jar=$(java-pkg_getjars --build-only junit)"
	echo "${antflags}"
}
