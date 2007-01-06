# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jfreechart/jfreechart-1.0.3.ebuild,v 1.2 2007/01/06 15:06:51 fordfrog Exp $

inherit java-pkg-2 java-ant-2 versionator

DESCRIPTION="JFreeChart is a free Java class library for generating charts"
HOMEPAGE="http://www.jfree.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="~x86 ~amd64"
IUSE="doc source test"
COMMON_DEPEND="
	>=dev-java/itext-1.4.6
	>=dev-java/jcommon-1.0.0
	=dev-java/servletapi-2.3*"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}
	dev-java/ant-core
	test? ( =dev-java/junit-3.8* )"
RDEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"

src_unpack() {
	unpack "${A}"

	cd "${S}/ant"
	epatch ${FILESDIR}/${P}-build.xml.patch

	cd "${S}"
	rm -f lib/* *.jar
}

src_compile() {
	# Note that compile-experimental depends on compile so it is sufficient to run
	# just compile-experimental
	eant -f ant/build.xml compile-experimental $(use_doc) $(get_jars)
}

src_test() {
	einfo "Please note that tests currently fail. See bug:"
	einfo "http://sourceforge.net/tracker/index.php?func=detail&aid=1629382&group_id=15494&atid=115494"
	ANT_TASKS="ant-junit" eant -f ant/build.xml test $(get_jars)
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
		-Djunit.jar=$(java-pkg_getjars junit)"
	echo "${antflags}"
}
