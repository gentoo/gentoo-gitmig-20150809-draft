# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nanoxml/nanoxml-2.2.1.ebuild,v 1.4 2004/10/22 09:42:59 absinthe Exp $

inherit java-pkg

DESCRIPTION="NanoXML is a small non-validating parser for Java. "

HOMEPAGE="http://nanoxml.sourceforge.net/"
MY_P=NanoXML-${PV}
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="virtual/jdk
		dev-java/sax"
RDEPEND="virtual/jre"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}/ThirdParty/SAX
	java-pkg_jar-from sax
	cd ${S}
	sed -e "s:/tmp/:${T}:" -i build.sh
}

src_compile() {
	./build.sh || die "failed to build"
}

src_install() {
	java-pkg_dojar Output/*.jar

	use doc && java-pkg_dohtml -r Documentation/*
}
