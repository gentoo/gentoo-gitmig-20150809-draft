# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/dom4j/dom4j-1.3.ebuild,v 1.1 2002/10/31 20:20:39 karltk Exp $

S=${WORKDIR}/dom4j-${PV}
DESCRIPTION="dom4j is an easy to use, open source library for working with XML, XPath and XSLT on the Java platform using the Java Collections Framework and with full support for DOM, SAX and JAXP."
SRC_URI="mirror://sourceforge/dom4j/${P}.tar.gz"
HOMEPAGE="http://dom4j.sourceforge.net"
DEPEND=">=virtual/jdk-1.3"
REDEPND=">=virtual/jdk-1.3"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64 alpha"
IUSE=""

src_compile() {
	cd ${WORKDIR}/dom4j-patched-${PV}
	sh build.sh || die "Compilation Failed"
}

src_install () {
	cd ${WORKDIR}/dom4j-patched-${PV}
	# If you need another jar change the name
	# of the file in dojar to the one you need
	dojar build/dom4j.jar
	dohtml -r build/doc/*
}

pkg_postinst() {
	einfo "dom4j creates 3 jar files:"
	einfo "------------------------------------------------------------------"
	einfo "dom4j-full.jar: this contains all the dom4j code, the XPath engine
    and the interfaces for SAX and DOM. If in doubt use this JAR."
	
	einfo "dom4j.jar this contains all the dom4j code and the XPath engine but
    without the SAX or DOM interfaces. Usually the SAX and DOM 
    interfaces come bundled with a JAXP parser so if you are using 
    JAXP and crimson.jar or xerces.jar then dom4j.jar is the 
    recommended JAR	to use."

	einfo "dom4j-core.jar this contains all the dom4j code without the XPath 
    engine and the SAX and DOM interfaces. This JAR is intended 
    for developers who wish to keep the dom4j.jar and the jaxen.jar 
    JARs seperate."
	einfo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	einfo "We are actually copying dom4j.jar. If you need another jar please
    feel free to modify the ebuild to fit your needs"
	einfo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	
}
