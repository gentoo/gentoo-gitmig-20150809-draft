# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta2-r1.ebuild,v 1.5 2006/03/11 20:06:09 hansmi Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://www.ibiblio.org/maven/jaxen/distributions/${PN}-1.1-beta-2-src.tar.gz"
LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="amd64 ppc sparc x86"
IUSE="doc jikes source"

RDEPEND="|| ( =virtual/jre-1.3* =virtual/jre-1.4* )
	>=dev-java/xerces-2.6.2-r1
	=dev-java/dom4j-1*
	~dev-java/jdom-1.0_beta9"

DEPEND="|| ( =virtual/jdk-1.3* =virtual/jdk-1.4* )
	jikes? ( dev-java/jikes )
	dev-java/ant-core
	>=sys-apps/sed-4
	${RDEPEND}"

S=${WORKDIR}/${PN}-1.1-beta-2

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff

	mkdir -p target/lib
	cd target/lib
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from jdom-1.0_beta9

	cd ${S}
	sed -i 's/depends="compile,test"/depends="compile"/' build.xml
}

src_compile() {
	local antops="jar"
	use jikes && antops="${antops} -Dbuild.compiler=jikes"
	use doc && antops="${antops} javadoc"
	ant ${antops} || die "compile failed"
}

src_install() {
	java-pkg_newjar target/jaxen*.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/main/*
}

