# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/fscript/fscript-1.15-r1.ebuild,v 1.1 2007/04/28 20:32:41 nelchael Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java based scripting engine designed to be embedded into other Java applications."
HOMEPAGE="http://fscript.sourceforge.net/"
SRC_URI="mirror://sourceforge/fscript/${P}.tgz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

EANT_DOC_TARGET="jdoc"

src_unpack() {

	unpack ${A}

	rm -f "${S}/FScript.jar"

}

src_install() {

	java-pkg_dojar *.jar

	dodoc CREDITS README VERSION
	# docs/* contains not only javadoc:
	use doc && java-pkg_dohtml -r docs/*
	use examples && cp -r examples/ ${D}/usr/share/${PN}/
	use source && java-pkg_dosrc src/*

}
