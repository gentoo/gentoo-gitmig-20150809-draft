# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaxen/jaxen-1.1_beta11.ebuild,v 1.5 2006/12/08 11:18:50 caster Exp $

inherit java-pkg-2 eutils java-ant-2

MY_P=${P/_beta/-beta-}
DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${MY_P}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc source test"

RDEPEND=">=virtual/jre-1.3
	~dev-java/jdom-1.0
	=dev-java/dom4j-1*
	=dev-java/xml-commons-external-1.3*
	>=dev-java/xerces-2.7
	dev-java/xom"

DEPEND=">=virtual/jdk-1.3
	!test? ( dev-java/ant-core )
	test? (
		dev-java/ant
		dev-java/junit
	)
	source? ( app-arch/zip )
	${RDEPEND}"


S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	# TODO file upstream
	epatch ${FILESDIR}/${P}-fix-jdk14-tests.patch

	mkdir -p ${S}/target/lib
	cd ${S}/target/lib
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar
	java-pkg_jar-from xerces-2
	java-pkg_jar-from dom4j-1
	java-pkg_jar-from jdom-1.0
	java-pkg_jar-from xom
	use test && java-pkg_jar-from --build-only junit

	cd ${S}
	# Make tests non-compuslatory
	sed -i 's/depends="compile,test"/depends="compile"/' build.xml
}

src_compile() {
	eant jar -Dnoget=1 $(use_doc)
}

src_install() {
	java-pkg_newjar target/${MY_P}.jar ${PN}.jar

	use doc && java-pkg_dohtml -r dist/docs/*
	use source && java-pkg_dosrc src/java/main/*
}

src_test() {
	if ! use test; then
		ewarn "You must be using the 'test' USE flag in order to"
		ewarn "get the dependencies to run tests."
		ewarn "Skipping tests..."
	else
		eant test -Dnoget=true
	fi
}
