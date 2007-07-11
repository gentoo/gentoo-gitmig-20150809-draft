# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jarbundler/jarbundler-1.8.1.ebuild,v 1.1 2007/07/11 06:19:09 ali_bush Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Jar Bundler Ant Task"
HOMEPAGE="http://www.loomcom.com/jarbundler/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4
		=dev-java/xerces-2*"
RDEPEND=">=virtual/jre-1.4
		 =dev-java/xerces-2*
		 dev-java/ant-core"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm *.jar
}

src_compile() {
	eant -Dant.jar="$(java-pkg_getjar ant-core ant.jar):$(java-pkg_getjars xerces-2)" jar $(use_doc javadocs)
}

src_install() {
	java-pkg_newjar "build/${P}.jar"
	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc src/*
}
