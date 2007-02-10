# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/cpptasks/cpptasks-1.0_beta4-r1.ebuild,v 1.1 2007/02/10 12:43:51 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

MY_P="${PN}-${PV/_beta/b}"
DESCRIPTION="Ant-tasks to compile various source languages and produce executables, shared libraries and static libraries"
HOMEPAGE="http://ant-contrib.sourceforge.net/"
SRC_URI="mirror://sourceforge/ant-contrib/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc source examples"

RDEPEND=">=virtual/jre-1.4
	 >=dev-java/ant-core-1.7
	 >=dev-java/xerces-2.7"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	source? ( app-arch/zip )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	# https://sourceforge.net/tracker/index.php?func=detail&aid=829906&group_id=36177&atid=416920
	# https://bugs.gentoo.org/show_bug.cgi?id=156596
	epatch "${FILESDIR}/1.0b4-profiling.patch"
	cd "${S}"
	rm -v *.jar || die
	java-ant_rewrite-classpath
}

EANT_BUILD_TARGET="jars"
EANT_DOC_TARGET="javadocs -Dbuild.javadocs=build/api"
EANT_GENTOO_CLASSPATH="ant-core,xerces-2"

src_install() {
	java-pkg_dojar build/lib/${PN}.jar

	java-pkg_register-ant-task

	dodoc NOTICE || die
	use doc && java-pkg_dojavadoc build/api
	use examples && dodoc samples/*
	use source && java-pkg_dosrc src/net

}
