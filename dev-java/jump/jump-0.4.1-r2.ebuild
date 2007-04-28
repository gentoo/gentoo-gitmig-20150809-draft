# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jump/jump-0.4.1-r2.ebuild,v 1.1 2007/04/28 12:52:57 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JUMP Ultimate Math Package (JUMP) is a Java-based extensible high-precision math package."
SRC_URI="mirror://sourceforge/${PN}-math/${P}.tar.gz"
HOMEPAGE="http://jump-math.sourceforge.net/"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=virtual/jdk-1.2"
RDEPEND=">=virtual/jre-1.2"

src_unpack() {

	unpack ${A}

	cd ${S}
	sed -i 's:${java.home}/src::' -i build.xml || die

}

EANT_DOC_TARGET="apidocs"

src_install() {

	java-pkg_dojar "build/${PN}.jar"

	use doc && java-pkg_dojavadoc "${S}/build/apidocs"
	use source && java-pkg_dosrc "${S}/src/main/org"

}
