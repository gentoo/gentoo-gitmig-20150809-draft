# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xp/xp-0.5-r1.ebuild,v 1.2 2007/01/28 21:30:44 betelgeuse Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="XP is an XML 1.0 parser written in Java"
HOMEPAGE="http://www.jclark.com/xml/xp"
SRC_URI="ftp://ftp.jclark.com/pub/xml/xp.zip"
LICENSE="JamesClark"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE="doc source"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -v xp.jar
	cp "${FILESDIR}/build.xml" .
}

src_compile() {
	eant jar #precompiled javadocs
}

src_install() {
	java-pkg_dojar xp.jar
	dodoc docs/copying.txt || die
	#has index.html and javadocs here
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc com
}
