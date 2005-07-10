# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-el/commons-el-1.0.ebuild,v 1.12 2005/07/10 13:54:07 axxo Exp $

inherit java-pkg

DESCRIPTION="EL is the JSP 2.0 Expression Language Interpreter from Apache."
HOMEPAGE="http://jakarta.apache.org/commons/el.html"
SRC_URI="mirror://apache/jakarta/commons/el/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE="jikes source"
RDEPEND=">=virtual/jre-1.4
	>=dev-java/servletapi-2.4"
DEPEND=">=virtual/jdk-1.4
	>=dev-java/ant-core-1.5
	${RDEPEND}
	jikes? ( dev-java/jikes )
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
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar || die "Unable to install"
	dodoc LICENSE.txt RELEASE-NOTES.txt
	dohtml STATUS.html PROPOSAL.html

	use source && java-pkg_dosrc src/java/org
}
