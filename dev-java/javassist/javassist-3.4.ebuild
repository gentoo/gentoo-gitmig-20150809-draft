# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/javassist/javassist-3.4.ebuild,v 1.1 2007/03/19 02:30:21 wltjr Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

# TODO add notes about where the distfile comes from
DESCRIPTION="Javassist makes Java bytecode manipulation simple."
SRC_URI="mirror://sourceforge/jboss/${P}.zip"
HOMEPAGE="http://www.csg.is.titech.ac.jp/~chiba/javassist/"

LICENSE="MPL-1.1"
SLOT="3"
KEYWORDS="~x86 ~amd64 ~ppc"

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	>=dev-java/ant-core-1.5
	source? ( app-arch/zip )"

src_unpack() {
	unpack ${A}
	cd "${S}" ||die
	java-ant_rewrite-classpath build.xml
}

src_compile() {
	cd "${S}"
	eant clean jar $(use_doc javadocs) -Dgentoo.classpath=$(java-config --tools)
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dohtml Readme.html
	use doc && java-pkg_dojavadoc html
	use source && java-pkg_dosrc src/main/javassist
}
