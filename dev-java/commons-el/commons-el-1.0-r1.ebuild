# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-el/commons-el-1.0-r1.ebuild,v 1.4 2006/12/09 09:11:52 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="EL is the JSP 2.0 Expression Language Interpreter from Apache."
HOMEPAGE="http://jakarta.apache.org/commons/el/"
SRC_URI="mirror://apache/jakarta/commons/el/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="source"
COMMON_DEP="~dev-java/servletapi-2.4"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	${COMMON_DEP}
	source? ( app-arch/zip )"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	mv build.properties build.properties.old

	echo "servlet-api.jar=$(java-pkg_getjar servletapi-2.4 servlet-api.jar)" >> build.properties
	echo "jsp-api.jar=$(java-pkg_getjar servletapi-2.4 jsp-api.jar)" >> build.properties
	echo "junit.jar = $(java-pkg_getjars junit)" >> build.properties
	echo "servletapi.build.notrequired = true" >> build.properties
	echo "jspapi.build.notrequired = true" >> build.properties

	# Build.xml is broken, fix it
	sed -i "s:../LICENSE:./LICENSE.txt:" build.xml || die "sed failed"
}

src_compile() {
	eant jar
}

src_install() {
	java-pkg_dojar dist/${PN}.jar || die "Unable to install"
	dodoc LICENSE.txt RELEASE-NOTES.txt
	dohtml STATUS.html PROPOSAL.html

	use source && java-pkg_dosrc src/java/org
}
