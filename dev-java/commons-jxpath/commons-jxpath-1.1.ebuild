# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jxpath/commons-jxpath-1.1.ebuild,v 1.6 2004/10/20 05:32:11 absinthe Exp $

inherit java-pkg

DESCRIPTION=" JXPath applies XPath expressions to graphs of objects of all kinds."
HOMEPAGE="http://jakarta.apache.org/commons/jxpath/"
SRC_URI="mirror://apache/jakarta/commons/jxpath/source/${PN}-${PV}-src.tar.gz"
DEPEND=">=virtual/jdk-1.3
	=dev-java/servletapi-2.3*
	=dev-java/jdom-1.0_beta9*
	>=dev-java/ant-1.4
	junit? ( >=dev-java/junit-3.7 )"
RDEPEND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="doc junit"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "jdom.jar=`java-config -p jdom`" > build.properties
	echo "servlet.jar=`java-config -p servletapi-2.3`" >> build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	use junit && antflags="${antflags} test"
	ant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dohtml PROPOSAL.html STATUS.html usersguide.html
	use doc && java-pkg_dohtml -r dist/docs/
}
