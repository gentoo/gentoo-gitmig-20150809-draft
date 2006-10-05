# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta7.ebuild,v 1.4 2006/10/05 17:23:40 gustavoz Exp $

inherit java-pkg eutils

MY_P=${P/_beta/-beta-}
DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${MY_P}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc jikes source test"

RDEPEND=">=virtual/jre-1.3
	~dev-java/jdom-1.0
	=dev-java/dom4j-1*
	>=dev-java/xerces-2.6
	dev-java/xom"

DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	jikes? ( dev-java/jikes )
	test? ( dev-java/ant-tasks )
	source? ( app-arch/zip )
	${RDEPEND}"


S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	mkdir -p ${S}/target/lib
	cd ${S}/target/lib
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from jdom-1.0
	java-pkg_jar-from xom

	cd ${S}
	# Make tests non-compuslatory
	sed -i 's/depends="compile,test"/depends="compile"/' build.xml
}

src_compile() {
	local antops="jar -Dnoget=true"
	use doc && antops="${antops} javadoc"
	use jikes && antops="${antops} -Dbuild.compiler=jikes"
	ant ${antops} || die "compile failed"
}

src_install() {
	java-pkg_newjar target/${MY_P}-SNAPSHOT.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/main/*
}

src_test() {
	if ! use test; then
		ewarn "You must be using the 'test' USE flag in order to"
		ewarn "get the dependencies to run tests."
		ewarn "Skipping tests..."
	else
		local antflags="test -Dnoget=true"
		ant ${antflags} || die "tests failed"
	fi
}
