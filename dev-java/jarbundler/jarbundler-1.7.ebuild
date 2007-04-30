# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jarbundler/jarbundler-1.7.ebuild,v 1.1 2007/04/30 11:22:30 ali_bush Exp $

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
		dev-java/ant-core"
RDEPEND=">=virtual/jre-1.4
		 dev-java/ant-core"

EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_newjar "build/${P}.jar"
	use doc && java-pkg_dojavadoc javadoc/
	use source && java-pkg_dosrc src/*
}
