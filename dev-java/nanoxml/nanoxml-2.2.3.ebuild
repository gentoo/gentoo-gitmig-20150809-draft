# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nanoxml/nanoxml-2.2.3.ebuild,v 1.2 2006/02/17 20:09:22 hansmi Exp $

inherit java-pkg

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
	sed -e "s:/tmp/:${T}:g" -i build.sh || die "failed to sed"
}

src_compile() {
	./build.sh || die "failed to build"
}

src_install() {
	java-pkg_dojar Output/*.jar

	use doc && java-pkg_dohtml -r Documentation/*
}
