# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dom4j/dom4j-1.5.ebuild,v 1.9 2006/10/05 15:37:30 gustavoz Exp $

inherit java-pkg

DESCRIPTION="Easy to use, open source library for working with XML, XPath and XSLT on the Java platform using the Java Collections Framework and with full support for DOM, SAX and JAXP."
HOMEPAGE="http://dom4j.sourceforge.net/"
SRC_URI="mirror://sourceforge/dom4j/${P}.tar.gz"
LICENSE="Apache-1.1"
SLOT="1"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE="doc"
DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.3* )"
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.3* )"

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
