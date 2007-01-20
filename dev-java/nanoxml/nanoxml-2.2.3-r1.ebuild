# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nanoxml/nanoxml-2.2.3-r1.ebuild,v 1.3 2007/01/20 19:00:16 nixnut Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="NanoXML is a small non-validating parser for Java. "

HOMEPAGE="http://nanoxml.sourceforge.net/"
MY_P=NanoXML-${PV}
SRC_URI="http://nanoxml.cyberelf.be/downloads/${MY_P}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3
		${RDEPEND}"
RDEPEND=">=virtual/jre-1.3
		dev-java/sax"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/ThirdParty/SAX
	java-pkg_jar-from sax
	cd ${S}
	# Use the right arguments for javac/javadoc
	sed -e "s:/tmp/:${T}:g" \
		-e "s/javac/javac $(java-pkg_javac-args)/" \
		-e "s/javadoc/javadoc -source $(java-pkg_get-source)/" \
		-i build.sh || die "failed to sed"
}

src_compile() {
	./build.sh || die "failed to build"
}

src_install() {
	java-pkg_dojar Output/*.jar

	use doc && java-pkg_dohtml -r Documentation/*
}
