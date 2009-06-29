# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/pdf-renderer/pdf-renderer-0.20090523.ebuild,v 1.4 2009/06/29 21:31:53 maekke Exp $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="a 100% Java PDF renderer and viewer"
HOMEPAGE="https://pdf-renderer.dev.java.net/"
# https://pdf-renderer.dev.java.net/demos/latest/PDFRenderer_src.zip
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
		app-arch/unzip
		${COMMON_DEP}"

S=${WORKDIR}/PDFRenderer_src

src_compile() {
	EANT_EXTRA_ARGS="-Dplatforms.JDK_1.5.home=\"${JAVA_HOME}\""
	java-pkg-2_src_compile
}

# There is a test target (default from Netbeans)
# but no junit code

src_install() {
	java-pkg_dojar dist/*.jar
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/com
}
