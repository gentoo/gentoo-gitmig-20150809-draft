# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta2.ebuild,v 1.2 2004/12/19 20:15:05 mr_bones_ Exp $

inherit java-pkg eutils

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://www.ibiblio.org/maven/jaxen/distributions/${PN}-1.1-beta-2-src.tar.gz
	junit? ( http://dev.gentoo.org/~karltk/projects/java/distfiles/jaxen-tests-1.1_beta2.tar.gz )"
LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE="doc jikes junit"

DEPEND=">=virtual/jdk-1.3
	jikes? ( dev-java/jikes )
	dev-java/ant
	>=sys-apps/sed-4
	${RDEPEND}"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xerces-2.6.2-r1
	=dev-java/dom4j-1*
	=dev-java/jdom-1.0_beta9"

S=${WORKDIR}/${PN}-1.1-beta-2

src_unpack() {
	unpack ${A}
	mv xml ${S}/
	cd ${S}
	epatch ${FILESDIR}/jaxen-1.1_beta2-gentoo.diff
	mkdir -p target/lib
	cd target/lib
	rm -f *.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from jdom
	java-pkg_jar-from dom4j-1

	cd ${S}
	if ! use junit ; then
		sed -i 's/depends="compile,test"/depends="compile"/' build.xml
	fi
}

src_compile() {
	local antops="jar"
	use jikes && antops="${antops} -Dbuild.compiler=jikes"
	use doc && antops="${antops} doc javadoc"
	ant ${antops} || die "compile failed"
}

src_install() {

	java-pkg_dojar target/jaxen*.jar

	use doc && java-pkg_dohtml -r target/doc/*
}
