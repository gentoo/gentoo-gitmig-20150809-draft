# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swing-layout/swing-layout-1.0.1-r1.ebuild,v 1.2 2006/12/09 09:25:52 flameeyes Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Professional cross platform layouts with Swing"
HOMEPAGE="https://swing-layout.dev.java.net/"
SRC_URI="https://swing-layout.dev.java.net/files/documents/2752/35842/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
		>=dev-java/ant-core-1.5
		app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_compile(){
	eant jar $(use_doc javadoc)
}

src_install(){
	java-pkg_dojar dist/swing-layout.jar
	dodoc releaseNotes.txt
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/java/org
}
