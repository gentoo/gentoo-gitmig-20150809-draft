# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jxpath/commons-jxpath-1.1-r2.ebuild,v 1.1 2006/07/22 22:58:20 nelchael Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Applies XPath expressions to graphs of objects of all kinds."
HOMEPAGE="http://jakarta.apache.org/commons/jxpath/"
SRC_URI="mirror://apache/jakarta/commons/jxpath/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=virtual/jre-1.3
	=dev-java/commons-beanutils-1.6*
	=dev-java/servletapi-2.3*
	~dev-java/jdom-1.0_beta9"
DEPEND=">=virtual/jdk-1.3
	${RDEPEND}
	dev-java/ant-core"

src_unpack() {
	unpack ${A}
	cd ${S}
	echo "jdom.jar=$(java-pkg_getjar jdom-1.0_beta9 jdom.jar)" > build.properties
	echo "servlet.jar=$(java-pkg_getjar servletapi-2.3 servlet.jar)" >> build.properties
	echo "commons-beanutils.jar=$(java-pkg_getjar commons-beanutils-1.6 commons-beanutils.jar)" >> build.properties
}

src_compile() {
	local antflags="jar"
	use doc && antflags="${antflags} javadoc"
	eant ${antflags} || die "compile problem"
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dohtml PROPOSAL.html STATUS.html usersguide.html
	use doc && java-pkg_dohtml -r dist/docs/
}
