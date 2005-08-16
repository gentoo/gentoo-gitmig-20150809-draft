# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.0.ebuild,v 1.10 2005/08/16 16:34:20 betelgeuse Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="mirror://sourceforge/jaxen/${P}-FCS.tar.gz"
LICENSE="jaxen"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc x86"
IUSE="doc junit source"
RDEPEND="|| ( =virtual/jre-1.4* =virtual/jre-1.3* )
	dev-java/xalan
	>=dev-java/xerces-2.6.2-r1
	=dev-java/dom4j-1*
	~dev-java/jdom-1.0_beta9
	dev-java/saxpath"

DEPEND="|| ( =virtual/jdk-1.4* =virtual/jdk-1.3* )
	dev-java/ant
	junit? ( dev-java/junit )
	${RDEPEND}"

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	mkdir src/conf
	cp ${FILESDIR}/MANIFEST.MF src/conf
	rm -f *.jar
	cd ${S}/lib
	rm -f *.jar

	java-pkg_jar-from saxpath
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1
	use junit && java-pkg_jar-from junit
	java-pkg_jar-from jdom-1.0_beta9
}

src_compile() {
	local antops="package"
	use doc && antops="${antops} doc javadoc"
	use junit && antops="${antops} test.core"
	ant ${antops} || die "compile failed"
}

src_install() {
	java-pkg_dojar build/jaxen-full.jar

	use doc && java-pkg_dohtml -r build/doc/*
	use source && java-pkg_dosrc src/java/main/*
}

