# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/nekohtml/nekohtml-0.9.5-r1.ebuild,v 1.1 2007/03/07 20:13:05 betelgeuse Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="A simple HTML scanner and tag balancer using standard XML interfaces."

HOMEPAGE="http://people.apache.org/~andyc/neko/doc/html/"
SRC_URI="http://www.apache.org/~andyc/neko/${P}.tar.gz"

COMMON_DEP="
		>=dev-java/xerces-2.7
		dev-java/xalan"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

LICENSE="CyberNeko-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

JAVA_PKG_BSFIX_NAME="build-html.xml"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v lib/*.jar *.jar || die
	# fixes compile errors due to API changes of xerces
	# TODO report upstream and fix properly instead of throwing
	# UnsupportedOperationException
	epatch ${FILESDIR}/${P}-xerces.patch
	# TODO sanify classpath for building, and submit upstream
	java-ant_rewrite-classpath build-html.xml
}

src_compile() {
	eant -f build-html.xml clean jar $(use_doc doc) \
		-Dgentoo.classpath=$(java-pkg_getjars xerces-2,xalan)
}

src_install() {
	java-pkg_dojar ${PN}.jar
	# TODO maybe have a samples useflag and install ${PN}Samples.jar

	dodoc README_html TODO_html || die
	# has other docs than javadoc too
	use doc && java-pkg_dohtml -r doc/html/*
	use source && java-pkg_dosrc ./src/html/org
}
