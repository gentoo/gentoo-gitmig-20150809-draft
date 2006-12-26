# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jelly/commons-jelly-1.0-r1.ebuild,v 1.3 2006/12/26 18:12:06 betelgeuse Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_P="${P}-src"
DESCRIPTION="A Java and XML based scripting and processing engine"
HOMEPAGE="http://jakarta.apache.org/commons/jelly/"
SRC_URI="mirror://apache/jakarta/commons/jelly/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86"
IUSE="doc test source"

RDEPEND=">=virtual/jre-1.4
	~dev-java/servletapi-2.3
	=dev-java/commons-cli-1*
	dev-java/commons-lang
	dev-java/commons-discovery
	dev-java/forehead
	dev-java/jakarta-jstl
	dev-java/commons-jexl
	=dev-java/commons-beanutils-1.6*
	dev-java/commons-collections
	=dev-java/dom4j-1*
	=dev-java/jaxen-1.1*
	>=dev-java/xerces-2.7
	dev-java/junit
	dev-java/commons-logging"

DEPEND=">=virtual/jdk-1.4
	dev-java/ant-core
	test? ( dev-java/ant-tasks )
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	# disables dependency fetching, and remove tests as a dependency of jar
	epatch ${FILESDIR}/${P}-gentoo.patch

	mkdir -p ${S}/lib
	cd ${S}/lib
	java-pkg_jar-from servletapi-2.3,commons-cli-1,commons-lang
	java-pkg_jar-from commons-discovery,forehead,jakarta-jstl,commons-jexl-1.0
	java-pkg_jar-from commons-beanutils-1.6,commons-collections
	java-pkg_jar-from dom4j-1,jaxen-1.1,xerces-2
	java-pkg_jar-from commons-logging,junit
}

src_compile() {
	eant -Dlibdir=lib jar $(use_doc)
}

src_test() {
	eant test -Dlibdir=lib
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	dodoc NOTICE.txt README.txt RELEASE-NOTES.txt

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
