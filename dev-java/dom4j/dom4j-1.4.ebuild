# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/dom4j/dom4j-1.4.ebuild,v 1.3 2004/03/18 13:10:23 dholm Exp $

DESCRIPTION="easy to use, open source library for working with XML, XPath and XSLT on the Java platform using the Java Collections Framework and with full support for DOM, SAX and JAXP."
HOMEPAGE="http://dom4j.sourceforge.net/"
SRC_URI="mirror://sourceforge/dom4j/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=virtual/jdk-1.3"
RDEPEND=">=virtual/jdk-1.3"

src_compile() {
	cd ${WORKDIR}/dom4j-${PV}
	sh build.sh || die "Compilation Failed"
}

src_install() {
	cd ${WORKDIR}/dom4j-${PV}
	# If you need another jar change the name
	# of the file in dojar to the one you need
	mv build/dom4j.jar build/dom4j-${PV}.jar
	dojar build/dom4j-${PV}.jar
	dohtml -r build/doc/*
}
