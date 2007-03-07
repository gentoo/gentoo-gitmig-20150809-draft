# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-digester/commons-digester-1.6-r2.ebuild,v 1.1 2007/03/07 04:38:03 wltjr Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Reads XML configuration files to provide initialization of various Java objects within the system."
HOMEPAGE="http://jakarta.apache.org/commons/digester/"
SRC_URI="mirror://apache/jakarta/commons/digester/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc source test"

RDEPEND=">=virtual/jre-1.4
	=dev-java/commons-beanutils-1.6*
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
DEPEND=">=virtual/jdk-1.4
	source? ( app-arch/zip )
	test? ( >=dev-java/junit-3.7 )
	${RDEPEND}"

S=${WORKDIR}/${P}-src

src_compile() {
	local antflags="dist"
#	use doc && antflags="${antflags} javadoc"
	if use test; then
		antflags="${antflags} test"
		antflags="${antflags} -Djunit.jar=$(java-pkg_getjars junit)"
	fi
	antflags="${antflags} -Dcommons-beanutils.jar=$(java-pkg_getjar commons-beanutils-1.6 commons-beanutils.jar)"
	antflags="${antflags} -Dcommons-collections.jar=$(java-pkg_getjars commons-collections)"
	antflags="${antflags} -Dcommons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)"
	eant ${antflags}
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java
}
