# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dom4j/dom4j-1.5.ebuild,v 1.4 2005/04/09 16:07:17 corsair Exp $

inherit java-pkg

DESCRIPTION="Easy to use, open source library for working with XML, XPath and XSLT on the Java platform using the Java Collections Framework and with full support for DOM, SAX and JAXP."
HOMEPAGE="http://dom4j.sourceforge.net/"
SRC_URI="mirror://sourceforge/dom4j/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~ppc64"
IUSE="doc"
DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	cd ${WORKDIR}/dom4j-${PV}
	ant -f build.xml package || die "Compilation Failed"
	if use doc; then
		ant -f build.xml javadoc || die "Javadoc Failed"
	fi
}

src_install() {
	cd ${WORKDIR}/dom4j-${PV}
	java-pkg_dojar build/${PN}.jar
	use doc && dohtml -r build/doc/*
}
