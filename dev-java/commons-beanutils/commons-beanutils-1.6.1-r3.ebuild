# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-beanutils/commons-beanutils-1.6.1-r3.ebuild,v 1.4 2006/10/17 03:44:02 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Provides easy-to-use wrappers around Reflection and Introspection APIs"
HOMEPAGE="http://jakarta.apache.org/commons/beanutils/"
SRC_URI="mirror://apache/jakarta/commons/beanutils/source/${P}-src.tar.gz"

LICENSE="Apache-1.1"
SLOT="1.6"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="doc source"

COMMON_DEP="
	>=dev-java/commons-collections-2.1
	>=dev-java/commons-logging-1.0.2"
RDEPEND=">=virtual/jre-1.3
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cd ${S}

	echo "commons-collections.jar=$(java-pkg_getjars commons-collections)" 	> build.properties
	echo "commons-logging.jar=$(java-pkg_getjar commons-logging commons-logging.jar)" >> build.properties
}

src_compile() {
	eant $(use_doc) jar
}

src_install() {
	java-pkg_dojar dist/${PN}*.jar

	dodoc RELEASE-NOTES.txt
	java-pkg_dohtml STATUS.html PROPOSAL.html

	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/org
}
