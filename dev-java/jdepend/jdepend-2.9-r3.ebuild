# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdepend/jdepend-2.9-r3.ebuild,v 1.2 2007/03/30 22:17:25 opfer Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JDepend traverses Java class file directories and generates design quality metrics for each Java package."
HOMEPAGE="http://www.clarkware.com/software/JDepend.html"
SRC_URI="http://www.clarkware.com/software/${P}.zip"

LICENSE="jdepend"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86 ~x86-fbsd"

DEPEND=">=virtual/jdk-1.4
	>=app-arch/unzip-5.50-r1"
RDEPEND=">=virtual/jre-1.4"

src_unpack() {
	unpack ${A}
	rm -v "${S}"/lib/*.jar || die
}

src_install() {
	java-pkg_newjar dist/jdepend-2.9.jar
	dodoc README || die
	dohtml -r docs/* || die

	dodir /usr/share/ant-core/lib
	dosym /usr/share/jdepend/lib/jdepend.jar /usr/share/ant-core/lib

	use doc && java-pkg_dojavadoc build/docs/api
	use source && java-pkg_dosrc src/*
}
