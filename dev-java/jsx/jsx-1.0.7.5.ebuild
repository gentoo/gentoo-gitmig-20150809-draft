# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsx/jsx-1.0.7.5.ebuild,v 1.6 2007/07/11 19:58:38 mr_bones_ Exp $

inherit java-pkg

DESCRIPTION="Java Serialization to XML (JSX) allows you to write and read any Java object graph as XML data with one line of code"
HOMEPAGE="http://www.csse.monash.edu.au/~bren/JSX/"
SRC_URI="http://www.csse.monash.edu.au/~bren/JSX/freeJSX${PV}.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""
DEPEND=">=virtual/jdk-1.2
	dev-java/java-config"
RDEPEND=">=virtual/jre-1.2"

S=${WORKDIR}

src_unpack() {
	jar xf ${DISTDIR}/${A} || die
	rm -f JSX/*.class JSX/magic/*.class
}

src_compile() {
	javac JSX/*.java JSX/magic/*.java || die "compilation failed"
}

src_install() {
	dodoc JSX/readme.txt
	jar cf jsx.jar JSX/*.class JSX/magic/*.class || die "failed to create jar"
	java-pkg_dojar jsx.jar
}
