# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsx/jsx-1.0.7.5-r1.ebuild,v 1.4 2008/01/05 12:49:47 caster Exp $

JAVA_PKG_IUSE="source"

inherit java-pkg-2

DESCRIPTION="Java Serialization to XML (JSX) allows you to write and read any Java object graph as XML data with one line of code"
HOMEPAGE="http://www.csse.monash.edu.au/~bren/JSX/"
SRC_URI="http://www.csse.monash.edu.au/~bren/JSX/freeJSX${PV}.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}"

src_unpack() {

	jar -xf "${DISTDIR}"/${A} || die "failed to unpack"

	rm -f JSX/*.class JSX/magic/*.class

}

src_compile() {

	ejavac JSX/*.java JSX/magic/*.java || die "compilation failed"
	jar cf jsx.jar JSX/*.class JSX/magic/*.class || die "failed to create jar"

}

src_install() {

	java-pkg_dojar jsx.jar

	dodoc JSX/readme.txt
	use source && java-pkg_dosrc "${S}"/JSX

}
