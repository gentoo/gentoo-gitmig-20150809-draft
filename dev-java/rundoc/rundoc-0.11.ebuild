# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rundoc/rundoc-0.11.ebuild,v 1.2 2007/01/25 23:12:07 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Ant helper task for keeping documentation in source files"
HOMEPAGE="http://www.martiansoftware.com/lab/index.html"
SRC_URI="http://www.martiansoftware.com/lab/${PN}/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc source"

COMMON_DEP=">=dev-java/ant-core-1.5.4"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar
	java-ant_rewrite-classpath
}

EANT_GENTOO_CLASSPATH="ant-core"

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/java/com
}

