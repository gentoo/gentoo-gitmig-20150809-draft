# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-el/commons-el-1.0.ebuild,v 1.2 2004/03/23 03:27:14 zx Exp $

inherit java-pkg

DESCRIPTION="EL is the JSP 2.0 Expression Language Interpreter from Apache."
HOMEPAGE="http://jakarta.apache.org/commons/el.html"
SRC_URI="mirror://apache/jakarta/commons/el/source/${P}-src.tar.gz"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="jikes"
DEPEND=">=virtual/jdk-1.4
		>=dev-java/servletapi-2.4
		>=dev-java/ant-1.5
		jikes? ( dev-java/jikes )"
RDEPEND=">=virtual/jdk-1.4"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	mv build.properties build.properties.old

	local SAPI="`java-config -p servletapi-2.4`"
	echo "servlet-api.jar=${SAPI/*:/}" >> build.properties
	echo "jsp-api.jar=${SAPI/:*/}" >> build.properties
	echo "junit.jar = `java-config --classpath=junit`" >> build.properties
	echo "servletapi.build.notrequired = true" >> build.properties
	echo "jspapi.build.notrequired = true" >> build.properties

	# Build.xml is broken, fix it
	sed -i "s:../LICENSE:./LICENSE.txt:" build.xml
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="{antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "compile problem"
}

src_install () {
	java-pkg_dojar dist/${PN}.jar || die "Unable to install"
	dodoc LICENSE.txt RELEASE-NOTES.txt
	dohtml STATUS.html PROPOSAL.html
}

