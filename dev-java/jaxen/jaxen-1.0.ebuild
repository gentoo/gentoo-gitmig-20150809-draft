# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.0.ebuild,v 1.3 2004/10/17 07:28:55 absinthe Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="mirror://sourceforge/jaxen/${P}-FCS.tar.gz"
LICENSE="jaxen"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc junit"
DEPEND="dev-java/ant
	junit? ( dev-java/junit )
	dev-java/xalan
	>=dev-java/xerces-2.6.2-r1
	=dev-java/dom4j-1*
	dev-java/jdom
	dev-java/saxpath"
#RDEPEND=""

S=${WORKDIR}/${P}-FCS

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/build.xml.patch
	mkdir src/conf
	cp ${FILESDIR}/MANIFEST.MF src/conf
	rm -f *.jar
	cd ${S}/lib
	rm -f ant-1.3.jar jakarta-ant-1.3-optional.jar junit.jar xerces.jar dom4j-core.jar

	java-pkg_jar-from saxpath
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	java-pkg_jar-from jdom
	java-pkg_jar-from dom4j-1
	use junit && java-pkg_jar-from junit
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
}
