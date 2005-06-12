# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta6.ebuild,v 1.1 2005/06/12 12:58:35 luckyduck Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${P/_beta6/-beta-6}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc jikes source"

DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	source? ( app-arch/zip )"
RDEPEND=">=virtual/jre-1.3
	~dev-java/jdom-1.0_beta9
	=dev-java/dom4j-1*
	=dev-java/xerces-2.6*
	dev-java/xom"

S=${WORKDIR}/${PN}-1.1-beta-6

src_unpack() {
	unpack ${A}

	mkdir -p ${S}/target/lib
	cd ${S}/target/lib
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from jdom-1.0_beta9
	java-pkg_jar-from xom

	cd ${S}
	sed -i 's/depends="compile,test"/depends="compile"/' build.xml
}

src_compile() {
	local antops="jar -Dnoget=1"
	use doc && antops="${antops} javadoc"
	use jikes && antops="${antops} -Dbuild.compiler=jikes"
	ant ${antops} || die "compile failed"
}

src_install() {
	mv target/jaxen*.jar target/${PN}.jar
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/main/*
}
